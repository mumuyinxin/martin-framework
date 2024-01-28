#ips=('martin-common-core')
ips=('martin-common-api' 'martin-common-bean' 'martin-common-bom' 'martin-common-core' 'martin-common-data' 'martin-common-feign' 'martin-common-log' 'martin-common-message' 'martin-common-oss' 'martin-common-security' 'martin-common-sentinel' 'martin-common-social' 'martin-common-swagger' 'martin-common-websocket')
#ips=('martin-common-data' 'martin-common-feign' 'martin-common-log' 'martin-common-message' 'martin-common-oss' 'martin-common-security' 'martin-common-sentinel' 'martin-common-social' 'martin-common-swagger' 'martin-common-websocket')

#for ip in ${ips[@]}
#do
#  echo `开始创建项目：${ip}`
#  git clone ~/repo/martin.origin ~/repo/${ip}
#  cd ~/repo/${ip}
#  git filter-repo --subdirectory-filter martin-common/${ip}
#  git remote add origin git@github.com:www-zerocode-net-cn/${ip}.git
#  git branch -M main
#  git push -u origin main
#  echo `结束创建项目：${ip}`
#done


# 创建子模块
cd ~/repo/martin-framework
git submodule add git@github.com:www-zerocode-net-cn/martin-common.git martin-common
cd ~/repo/martin-framework/martin-common
for ip in ${ips[@]}
do
  echo '开始创建子模块：'${ip}
  git submodule add git@github.com:www-zerocode-net-cn/${ip}.git ${ip}
  echo `结束创建子模块：${ip}`
done
