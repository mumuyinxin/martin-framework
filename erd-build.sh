cd /Users/masterliang/repo/martin-framework
mvn clean install -Prelease -DskipTests=true

ERD_VERSION=5.0.0

cd /Users/masterliang/repo/martin-framework/ui
docker buildx build --platform linux/amd64 -t erdonline/erd-ui:$ERD_VERSION -o type=docker .

cd /Users/masterliang/repo/martin-framework/martin-cloud/martin-cloud-nacos
docker buildx build --platform linux/amd64 -t erdonline/erd-nacos:$ERD_VERSION -o type=docker .

cd /Users/masterliang/repo/martin-framework/martin-extension/martin-extension-ncnb
docker buildx build --platform linux/amd64 -t erdonline/erd-zerocode:$ERD_VERSION -o type=docker .

cd /Users/masterliang/repo/martin-framework/martin-cloud/martin-cloud-gateway
docker buildx build --platform linux/amd64 -t erdonline/erd-gateway:$ERD_VERSION -o type=docker .

cd /Users/masterliang/repo/martin-framework/martin-biz/martin-biz-auth
docker buildx build --platform linux/amd64 -t erdonline/erd-auth:$ERD_VERSION -o type=docker .

cd /Users/masterliang/repo/martin-framework/martin-biz/martin-biz-system
docker buildx build --platform linux/amd64 -t erdonline/erd-system:$ERD_VERSION -o type=docker .

cd /Users/masterliang/repo/martin-framework/db
docker buildx build --platform linux/amd64 -t erdonline/erd-mysql:$ERD_VERSION -o type=docker .

cd /Users/masterliang/repo/martin-framework/elk-monitor-trace/minio
docker buildx build --platform linux/amd64 -t erdonline/erd-minio:$ERD_VERSION -o type=docker .

cd /Users/masterliang/repo/martin-framework/elk-monitor-trace/redis
docker buildx build --platform linux/amd64 -t erdonline/erd-redis:$ERD_VERSION -o type=docker .

echo 'docker build finished!'

cd /Users/masterliang/repo/martin-framework

rm -rf ERDOnlineDockerImg-$ERD_VERSION.tar.gz
# shellcheck disable=SC2046
docker save -o ERDOnlineDockerImg-$ERD_VERSION.tar $(docker images | grep -v REPOSITORY | grep erdonline | grep -v jdk | grep $ERD_VERSION | awk 'BEGIN{OFS=":";ORS=" "}{print $1,$2}')

echo 'docker save finished!'

tar cvzf ERDOnlineDockerImg-$ERD_VERSION.tar.gz ERDOnlineDockerImg-$ERD_VERSION.tar

echo 'GZIP finished!'
