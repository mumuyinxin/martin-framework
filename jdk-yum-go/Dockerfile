FROM openjdk:8u312-jdk-oraclelinux7

MAINTAINER martin114@foxmail.com

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

COPY --from=golang:1.15.3-alpine /usr/local/go /usr/local/go

COPY --from=golang:1.15.3-alpine /lib/* /lib/

ENV PATH=$PATH:/usr/local/go/bin

RUN go version