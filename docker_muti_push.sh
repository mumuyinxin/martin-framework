ERD_VERSION=5.0.1

#cd /Users/masterliang/idea_project/martin/jdk-yum-go/
#docker buildx build --platform linux/arm64,linux/amd64 -t erdonline/jdk8-yum-go:latest . --push
#
#cd /Users/masterliang/repo/martin-framework/ui
#docker buildx build  --platform linux/arm64,linux/amd64 -t erdonline/erd-ui:latest . --push
#docker buildx build --platform linux/arm64,linux/amd64 -t erdonline/erd-ui:$ERD_VERSION . --push
#
#cd /Users/masterliang/repo/martin-framework/martin-cloud/martin-cloud-nacos
#docker buildx build --platform linux/arm64,linux/amd64 -t erdonline/erd-nacos:latest . --push
#docker buildx build --platform linux/arm64,linux/amd64 -t erdonline/erd-nacos:$ERD_VERSION . --push

#cd /Users/masterliang/repo/martin-framework/martin-extension/martin-extension-ncnb
#docker buildx build --platform linux/arm64,linux/amd64 -t erdonline/erd-zerocode:latest . --push
#docker buildx build --platform linux/arm64,linux/amd64 -t erdonline/erd-zerocode:$ERD_VERSION . --push

#cd /Users/masterliang/repo/martin-framework/martin-extension/martin-extension-loco
#docker buildx build --platform linux/arm64,linux/amd64 -t erdonline/loco-api:latest . --push
#docker buildx build --platform linux/arm64,linux/amd64 -t erdonline/loco-api:$ERD_VERSION . --push

#cd /Users/masterliang/repo/martin-framework/martin-cloud/martin-cloud-gateway
#docker buildx build --platform linux/arm64,linux/amd64 -t erdonline/erd-gateway:latest . --push
#docker buildx build --platform linux/arm64,linux/amd64 -t erdonline/erd-gateway:$ERD_VERSION . --push
#
#cd /Users/masterliang/repo/martin-framework/martin-biz/martin-biz-auth
#docker buildx build --platform linux/arm64,linux/amd64 -t erdonline/erd-auth:latest . --push
#docker buildx build --platform linux/arm64,linux/amd64 -t erdonline/erd-auth:$ERD_VERSION . --push
#
#cd /Users/masterliang/repo/martin-framework/martin-biz/martin-biz-system
#docker buildx build --platform linux/arm64,linux/amd64 -t erdonline/erd-system:latest . --push
#docker buildx build --platform linux/arm64,linux/amd64 -t erdonline/erd-system:$ERD_VERSION . --push

cd /Users/masterliang/repo/martin-framework/martin-biz/martin-biz-trans
docker buildx build --platform linux/arm64,linux/amd64 -t erdonline/erd-trans:latest . --push
docker buildx build --platform linux/arm64,linux/amd64 -t erdonline/erd-trans:$ERD_VERSION . --push

#cd /Users/masterliang/repo/martin-framework/db
#docker buildx build --platform linux/arm64,linux/amd64 -t erdonline/erd-mysql:latest . --push
#docker buildx build --platform linux/arm64,linux/amd64 -t erdonline/erd-mysql:$ERD_VERSION . --push
#
#cd /Users/masterliang/repo/martin-framework/elk-monitor-trace/minio
#docker buildx build --platform linux/arm64,linux/amd64 -t erdonline/erd-minio:latest . --push
#docker buildx build --platform linux/arm64,linux/amd64 -t erdonline/erd-minio:$ERD_VERSION . --push
#
#cd /Users/masterliang/repo/martin-framework/elk-monitor-trace/redis
#docker buildx build --platform linux/arm64,linux/amd64 -t erdonline/erd-redis:latest . --push
#docker buildx build --platform linux/arm64,linux/amd64 -t erdonline/erd-redis:$ERD_VERSION . --push




