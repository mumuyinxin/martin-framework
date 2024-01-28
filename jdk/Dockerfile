FROM --platform=linux/arm64/v8 ubuntu:20.04

MAINTAINER martin114@foxmail.com

ARG DEBIAN_FRONTEND=noninteractive

ARG timedatectl set-local-rtc 0 --adjust-system-clock


RUN  sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list
RUN  apt-get clean
RUN apt-get update

RUN apt update \
    && apt upgrade -y \
    && apt install -y openjdk-8-jre vim multitail\
    && apt clean
