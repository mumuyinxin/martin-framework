FROM erdonline/jdk8-yum-go:latest

MAINTAINER martin114@foxmail.com

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN mkdir -p /martin-sentinel

WORKDIR /martin-sentinel

EXPOSE 9604

ADD ./sentinel/sentinel-dashboard-1.8.0.jar ./

ENTRYPOINT ./xjar java ${JAVA_OPTS} -Djava.security.egd=file:/dev/./urandom -jar sentinel-dashboard-1.8.0.jar
