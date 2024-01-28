FROM mysql:8.0.28-oracle

MAINTAINER martin114@foxmail.com

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#定义工作目录
ENV WORK_PATH /usr/local/work

#定义会被容器自动执行的目录
ENV AUTO_RUN_DIR /docker-entrypoint-initdb.d

#定义sql文件名
ENV SCHEMA 1schema.sql
ENV ERD 2erd.sql
ENV MARTIN 3martin.sql
ENV NACOS 4nacos.sql
ENV PRIVILEGES 5privileges.sql

#定义shell文件名
ENV INSTALL_DB_SHELL install_db.sh

#创建文件夹
RUN mkdir -p $WORK_PATH

#把数据库初始化数据的文件复制到工作目录下
COPY ./$SCHEMA $WORK_PATH/
COPY ./$ERD $WORK_PATH/
COPY ./$MARTIN $WORK_PATH/
COPY ./$NACOS $WORK_PATH/
COPY ./$PRIVILEGES $WORK_PATH/

#把要执行的shell文件放到/docker-entrypoint-initdb.d/目录下，容器会自动执行这个shell
COPY ./$INSTALL_DB_SHELL $AUTO_RUN_DIR/

#给执行文件增加可执行权限
RUN chmod a+x $AUTO_RUN_DIR/$INSTALL_DB_SHELL


COPY ./1schema.sql /docker-entrypoint-initdb.d
COPY ./2erd.sql /docker-entrypoint-initdb.d
COPY ./3martin.sql /docker-entrypoint-initdb.d
COPY 4nacos.sql /docker-entrypoint-initdb.d
COPY ./5privileges.sql /docker-entrypoint-initdb.d
