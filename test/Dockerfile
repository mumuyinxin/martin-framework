FROM openjdk:11-jdk-slim-bullseye AS build-env
COPY . /app/examples
WORKDIR /app
RUN javac examples/*.java
RUN jar cfe main.jar examples.HelloJava examples/*.class

FROM gcr.io/distroless/java11-debian11
COPY --from=build-env /app /app
WORKDIR /app
CMD ["main.jar"]

FROM openjdk:8u312-jdk-oraclelinux7

MAINTAINER martin114@foxmail.com

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

COPY --from=golang:1.15.3-alpine /usr/local/go /usr/local/go

COPY --from=golang:1.15.3-alpine /lib/* /lib/

ENV PATH=$PATH:/usr/local/go/bin

RUN go version