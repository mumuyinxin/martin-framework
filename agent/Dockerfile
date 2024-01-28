FROM erdonline/jdk8-yum-go:latest

MAINTAINER martin114@foxmail.com

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN mkdir -p /martin-skywalking

WORKDIR /martin-skywalking


ADD ./agent8.4.0.tar.gz ./

