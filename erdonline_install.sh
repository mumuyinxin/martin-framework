#!/bin/bash

DIR=.
ERD_HOME=${HOME}/.erd

ERD_VERSION=5.0.0

GREEN='\033[0;32m'
RED='\033[0;31m'
NO_COLOR='\033[0m'
LIGHT_BLUE='\033[0;34m'
YELLOW='\033[0;33m'

LOG_PATH=${DIR}/installer.log

logSuccess() {
  printf "${GREEN} $1${NO_COLOR}\n" 1>&2
  printf "[SUCCESS] $1 \n" >>"${LOG_PATH}"
}

logPrompt() {
  printf " $1\n" 1>&2
  printf "[PROMPT] $1\n" >>"${LOG_PATH}"
}

logInfo() {
  printf "[INFO] $1\n" 1>&2
  printf "[INFO] $1\n" >>"${LOG_PATH}"
}

logWarn() {
  printf "${YELLOW} $1${NO_COLOR}\n" 1>&2
  printf "[WARN] $1\n" >>"${LOG_PATH}"
}

logError() {
  printf "${RED}[ERROR] $1${NO_COLOR}\n" 1>&2
  printf "[ERROR] $1\n" >>"${LOG_PATH}"
}

RunCommandWithLog() {
  local cmd=$@
  $cmd 2>&1 | tee -a ${LOG_PATH}
}

printLogo() {
  printf "${YELLOW}    __________  ____     ____        ___          \n"
  printf "${YELLOW}   / ____/ __ \/ __ \   / __ \____  / (_)___  ___ \n"
  printf "${YELLOW}  / __/ / /_/ / / / /  / / / / __ \/ / / __ \/ _ \\n"
  printf "${YELLOW} / /___/ _, _/ /_/ /  / /_/ / / / / / / / / /  __/\n"
  printf "${YELLOW}/_____/_/ |_/_____/   \____/_/ /_/_/_/_/ /_/\___/ \n"
  printf "${YELLOW}                                                  \n"
}

fail() {
  logError "$@"
  exit 1
}

confirmDefaultNo() {
  promptTimeout "$@"
  if [ "$PROMPT_RESULT" = "y" ] || [ "$PROMPT_RESULT" = "Y" ]; then
    return 0
  fi
  return 1
}

confirmDefaultYes() {
  promptTimeout "$@"
  if [ "$PROMPT_RESULT" = "n" ] || [ "$PROMPT_RESULT" = "N" ]; then
    return 1
  fi
  return 0
}

if [ -z "$READ_TIMEOUT" ]; then
  READ_TIMEOUT="-t 20"
fi

promptTimeout() {
  set +e
  read ${READ_TIMEOUT} PROMPT_RESULT </dev/tty
  set -e
}

getInput() {
  set +e
  read PROMPT_RESULT </dev/tty
  set -e
}

checkCmdExists() {
  command -v "$@" >/dev/null 2>&1
}

checkForRoot() {
  local user="$(id -un 2>/dev/null || true)"
  if [ "$user" != "root" ]; then
    fail "this installer needs to be run as root."
  fi
  FLAG_ROOT_CHECK=true
}

render_yaml_file() {
  eval "echo \"$(cat $1)\""
}

loadImages() {
  find "$1" -type f | xargs -I {} bash -c "docker load < {}"
}

cleanUp() {
  logInfo "Cleaning up all the installation package..."
  logSuccess "Clean up success!"
}
getSystemInfos() {
  getDockerVersion
  getLsbInfo
  getPublicIp
  getPrivateIp
  #TODO: system spec verification

  KERNEL_MAJOR=$(uname -r | cut -d'.' -f1)
  KERNEL_MINOR=$(uname -r | cut -d'.' -f2)
}

getDockerVersion() {
  if ! checkCmdExists "docker"; then
    return
  fi
  DOCKER_VERSION=$(docker -v | awk '{gsub(/,/, "", $3); print $3}')
}

LSB_DIST=
DIST_VERSION=
DIST_VERSION_MAJOR=
getLsbInfo() {
  _dist=
  if [ -f /etc/centos-release ] && [ -r /etc/centos-release ]; then
    # CentOS 6 & 7
    _dist="$(cat /etc/centos-release | cut -d" " -f1)"
    _version="$(cat /etc/centos-release | sed 's/Linux //' | cut -d" " -f3 | cut -d "." -f1-2)"
  elif [ -f /etc/os-release ] && [ -r /etc/os-release ]; then
    _dist="$(. /etc/os-release && echo "$ID")"
    _version="$(. /etc/os-release && echo "$VERSION_ID")"
  elif [ -f /etc/redhat-release ] && [ -r /etc/redhad-release ]; then
    # RHEL 6
    _dist="rhel"
    _major_version=$(cat /etc/redhat-release | cut -d" " -f7 | cut -d "." -f1)
    _minor_version=$(cat /etc/redhat-release | cut -d" " -f7 | cut -d "." -f2)
    _version=$_major_version
  else
    _err="Cannot determine what lsb is currently running."
  fi

  if [ -n "$_dist" ]; then
    _err="Detected lsb: ${_dist}"
    _dist="$(echo "$_dist" | tr '[:upper:]' '[:lower:]')"
    case "$_dist" in
    ubuntu)
      _err="$_err\nHowever detected version $_version is less than 12."
      oIFS="$IFS"
      IFS=.
      set -- $_version
      IFS="$oIFS"
      [ $1 -ge 12 ] && LSB_DIST=$_dist && DIST_VERSION=$_version && DIST_VERSION_MAJOR=$1
      ;;
    debian)
      _err="$_err\nHowever detected version $_version is less than 7."
      oIFS="$IFS"
      IFS=.
      set -- $_version
      IFS="$oIFS"
      [ $1 -ge 7 ] && LSB_DIST=$_dist && DIST_VERSION=$_version && DIST_VERSION_MAJOR=$1
      ;;
    centos)
      _error_msg="$_error_msg\nHowever detected version $_version is less than 6."
      oIFS="$IFS"
      IFS=.
      set -- $_version
      IFS="$oIFS"
      [ $1 -ge 6 ] && LSB_DIST=$_dist && DIST_VERSION=$_version && DIST_VERSION_MAJOR=$1
      ;;
    esac
  fi

  if [ -z "$LSB_DIST" ]; then
    logError "$(echo | sed "i$_err")"
    logError "Quitting..."
    exit 1
  fi
}

getPrivateIp() {
  if [ -n "$PRIVATE_ADDRESS" ]; then
    return 0
  fi

  PRIVATE_ADDRESS=$(ip addr | grep eth0 | awk '/^[0-9]+: / {}; /inet.*global/ {print gensub(/(.*)\/(.*)/, "\\1", "g", $2)}')
}

getPublicIp() {
  PUBLIC_ADDRESS=$(dig +short myip.opendns.com @resolver1.opendns.com)
}

FLAG_ROOT_CHECK=
FLAG_REQ_CHECK=
FLAG_DOCKER=
FLAG_DOCKER_COMPOSE=
FLAG_CLUSTER_READY=
FLAG_ERD=

trap reportStatus EXIT

reportStatus() {
  logPrompt "*****************************************"
  logPrompt "*    ERD Online installer exit report    *"
  logPrompt "*****************************************"
  if [ -z "$FLAG_ROOT_CHECK" ]; then
    logError "⚙ ROOT PRIVILEGE CHECK FAILED"
  else
    logSuccess "✔ ROOT PRIVILEGE CHECK SUCCESS"
  fi

  if [ -z "$FLAG_REQ_CHECK" ]; then
    logError "⚙ SYSTEM CHECK FAILED"
  else
    logSuccess "✔ SYSTEM CHECK SUCCESS"
  fi

  if [ -z "$FLAG_DOCKER" ]; then
    logError "⚙ DOCKER INSTALLATION FAILED"
  else
    logSuccess "✔ DOCKER INSTALLATION SUCCESS"
  fi

  if [ -z "$FLAG_DOCKER_COMPOSE" ]; then
    logError "⚙ DOCKER-COMPOSE INSTALLATION FAILED"
  else
    logSuccess "✔ DOCKER-COMPOSE INSTALLATION SUCCESS"
  fi

  if [ -z "$FLAG_ERD" ]; then
    logError "⚙ ERD INSTALLATION FAILED"
  else
    logSuccess "✔ ERD INSTALLATION SUCCESS"
    logSuccess "ERD Online webDomain: $UI_URL"
    logSuccess "ERD Online user: admin"
    logSuccess "ERD Online password: 123456"
  fi

  logPrompt "*****************************************"
  logPrompt "*            END OF REPORT              *"
  logPrompt "*****************************************"
}
reportTime() {
  local behavior=$1
  if (($SECONDS > 3600)); then
    let "hours=SECONDS/3600"
    let "minutes=(SECONDS%3600)/60"
    let "seconds=(SECONDS%3600)%60"
    logSuccess "${behavior} completed in $hours hour(s), $minutes minute(s) and $seconds second(s)"
  elif (($SECONDS > 60)); then
    let "minutes=(SECONDS%3600)/60"
    let "seconds=(SECONDS%3600)%60"
    logSuccess "${behavior} completed in $minutes minute(s) and $seconds second(s)"
  else
    logSuccess "${behavior} completed in $SECONDS seconds"
  fi
}

TIMER_TIME=
setTimer() {
  TIMER_TIME=$SECONDS
}

preflightCheck() {
  check64Bit
  checkIfSupportedOS
  checkFirewalld
  checkSelinuxDisabled
  FLAG_REQ_CHECK=true
}

check64Bit() {
  case "$(uname -m)" in
  *64) ;;

  *)
    fail "This installer only works on 64 bit system"
    ;;
  esac
}

checkIfSupportedOS() {
  case "$LSB_DIST$DIST_VERSION" in
  ubuntu16.04 | ubuntu18.04 | ubuntu20.04 | centos7.4 | centos7.5 | centos7.6 | centos7.7 | centos7.8 | centos7.9 | centos8.0 | centos8.1 | centos8.2 | centos8.3) ;;

  *)
    fail "This installer does not support ${LSB_DIST} ${DIST_VERSION}"
    ;;
  esac
}

checkFirewalld() {
  if ! systemctl -q is-active firewalld; then
    return
  fi

  logWarn "Firewalld is active, do you want to disable it? [y/N]"
  if confirmDefaultNo; then
    systemctl stop firewalld
    systemctl disable firewalld
    return
  fi

  fail "The system cannot continue with firewalld on"
}

checkSelinuxDisabled() {
  if selinuxEnabled && selinuxEnforced; then
    logError "kubernetes is incompatible with selinux, disable it? [y/N]"
    if confirmDefaultNo; then
      setenforce 0
      sed -i s/^SELINUX=.*$/SELINUX=permissive/ /etc/selinux/config
    else
      fail "disable selinux to continue"
    fi
  fi
}

selinuxEnabled() {
  if checkCmdExists "selinuxenabled"; then
    selinuxenabled
    return
  elif checkCmdExists "sestatus"; then
    ENABLED=$(sestatus | grep 'SELinux status' | awk '{ print $3 }')
    echo "$ENABLED" | grep --quiet --ignore-case enabled
    return
  fi

  return 1
}

selinuxEnforced() {
  if checkCmdExists "getenforce"; then
    ENFORCED=$(getenforce)
    echo $(getenforce) | grep --quiet --ignore-case enforcing
    return
  elif checkCmdExists "sestatus"; then
    ENFORCED=$(sestatus | grep 'SELinux mode' | awk '{ print $3 }')
    echo "$ENFORCED" | grep --quiet --ignore-case enforcing
    return
  fi

  return 1
}

installCri() {
  if ! checkCmdExists docker; then
    logInfo "fetching docker..."
    installDocker
  fi
  if ! checkCmdExists docker-compose; then
    logInfo "fetching docker-compose..."
    installDockerCompose
  fi
  printf "\n"
  FLAG_DOCKER=true
  FLAG_DOCKER_COMPOSE=true
}

installDocker() {
  cgroupToSystemd
  downloadDockerPackage
  runDockerInstall
  systemctl enable docker
  systemctl start docker
}

installDockerCompose() {
  docker_compose='docker-compose'
  curl -# -L https://www.erdonline.com/pkg/docker-compose-linux-2.5.1-x86_64 -o ./${docker_compose}
  chmod 777 ${docker_compose}
  mv -f ${docker_compose} /usr/local/bin
}

cgroupToSystemd() {
  if [ -f /etc/docker/daemon.json ]; then
    return
  fi

  mkdir -p /etc/docker
  cat >/etc/docker/daemon.json <<EOF
{
    "exec-opts": ["native.cgroupdriver=systemd"],
    "registry-mirrors": ["https://hub-mirror.c.163.com/"]
}
EOF

  mkdir -p /etc/systemd/system/docker.service.d
}

downloadDockerPackage() {
  local version="19.03.10"
  # TODO: add more docker dist package and make it available to customer choice
  curl -# -LO "https://www.erdonline.com/pkg/docker-${version}.tar.gz" 2>&1
  tar xzf docker-${version}.tar.gz
  rm docker-${version}.tar.gz
}

runDockerInstall() {
  local version="19.03.10"
  case "$LSB_DIST" in
  ubuntu)
    RunCommandWithLog dpkg --install --force-depends-version $DIR/packages/docker/${version}/ubuntu-${DIST_VERSION}/*.deb
    return 0
    ;;
  centos | rhel)
    RunCommandWithLog rpm --upgrade --force --nodeps $DIR/packages/docker/${version}/rhel-7/*.rpm
    return 0
    ;;
  esac

  fail "Docker installation is currently not supported on ${LSB_DIST} ${DIST_VERSION_MAJOR}"
}

getERDInstallParam() {
  getDomain "-t 60"
}

MODE=quickstart

if [[ ${MODE} == "nightly" ]]; then
  ERD_VERSION=1-nightly
else
  ERD_VERSION=${ERD_VERSION}
fi

# logging color
RED='\033[0;31m'
NO_COLOR='\033[0m'

cleanup() {
  set +e
  rm -rf "${ERD_HOME}"
  rm -rf "${DIR}/packages"
  set -e
}

UI_URL=

ensure_parameter() {
  # opensource version
  ensure_endpoint
}

ensure_endpoint() {
  if { { [ -z "${IP}" ] || [ -z "${PORT}" ];} && [ -z "${DOMAIN}" ]; } || { [ -n "${IP}" ] && [ -n "${DOMAIN}" ]; }; then
    printf "${RED}Either IP+PORT or DOMAIN shoule be provided${NOCOLOR}\n"
    exit 1
  fi

  # Set corresponding install parameters
  if [ -n "${IP}" ]; then
    UI_URL=http://${IP}:${PORT}
  else
    UI_URL=http://${DOMAIN}
   fi
}


installERD() {
  ensure_parameter
  cleanup
  echo "installing ERD Online ..."
  downloadERDOnline
  startERDOnline
  cleanup
}

downloadERDOnline() {
  echo "download ERD Online config..."
  curl -# -LO "https://www.erdonline.com/pkg/ERDOnline-${ERD_VERSION}.tar.gz" 2>&1
  tar xzf ERDOnline-${ERD_VERSION}.tar.gz
  rm ERDOnline-${ERD_VERSION}.tar.gz
  local totalImage=$(docker images | grep -v REPOSITORY | grep erdonline | grep -v jdk | grep ${ERD_VERSION} | awk 'BEGIN{OFS=":";ORS=" "}{print $1,$2}' | wc -w)
  if [ "${totalImage}" -ne 9 ]; then
    echo "download ERD Online image..."
    curl -# -LO "https://www.erdonline.com/pkg/ERDOnlineDockerImg-${ERD_VERSION}.tar.gz" 2>&1
    tar xzf ERDOnlineDockerImg-${ERD_VERSION}.tar.gz
    echo "load ERD Online image..."
    docker load -q -i ERDOnlineDockerImg-${ERD_VERSION}.tar
    rm -rf ERDOnlineDockerImg-${ERD_VERSION}.tar.gz
    rm -rf ERDOnlineDockerImg-${ERD_VERSION}.tar
  fi

}

startERDOnline() {
  ERD_NETWORK=$(docker network ls | grep erd | awk '{print $2}')
  if [ -z "$ERD_NETWORK" ]; then
    docker network create erd
  fi
  rm -rf ./env/ui.env
  touch ./env/ui.env
  echo "API_URL=$UI_URL" >>./env/ui.env
  docker-compose up -d erd-redis erd-mysql
  echo "starting redis、mysql ..."
  sleep 60s
  docker-compose up -d erd-nacos
  echo "starting nacos ..."
  sleep 30s
  docker-compose up -d
  echo "starting ERD service ..."
  sleep 120s
}

postInstallERD() {
  logSuccess "ERD Online installation complete."
  FLAG_ERD=true
}
main() {
  printLogo
  logSuccess "Welcome to the ERD Online Installer,current version is ${ERD_VERSION}"
  logInfo "Checking system for requirements..."
  setTimer
  checkForRoot
  getSystemInfos
  preflightCheck
  reportTime "preflight check"
  setTimer
  mkdir -p ${ERD_HOME}/mypkg
  reportTime "install preparation"
  setTimer
  installCri
  reportTime "infrastructure installation"
  setTimer
  installERD
  postInstallERD
  reportTime "erd installation"
}

main
