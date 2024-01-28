ERD_VERSION=5.0.0

#cd /Users/masterliang/idea_project/martin/jdk-yum-go/
#docker buildx build --platform linux/arm64 -t erdonline/jdk8-yum-go:latest .

cd /Users/masterliang/repo/martin-framework/ui
docker buildx build --platform linux/arm64 -t erdonline/erd-ui:$ERD_VERSION . --load

cd /Users/masterliang/repo/martin-framework/martin-cloud/martin-cloud-nacos
docker buildx build --platform linux/arm64 -t erdonline/erd-nacos:$ERD_VERSION . --load

cd /Users/masterliang/repo/martin-framework/martin-extension/martin-extension-ncnb
docker buildx build --platform linux/arm64 -t erdonline/erd-zerocode:$ERD_VERSION . --load

#cd /Users/masterliang/repo/martin-framework/martin-extension/martin-extension-loco
#docker buildx build --platform linux/arm64 -t erdonline/loco-api:latest . 
#docker buildx build --platform linux/arm64 -t erdonline/loco-api:$ERD_VERSION . 

cd /Users/masterliang/repo/martin-framework/martin-cloud/martin-cloud-gateway
docker buildx build --platform linux/arm64 -t erdonline/erd-gateway:$ERD_VERSION . --load

cd /Users/masterliang/repo/martin-framework/martin-biz/martin-biz-auth
docker buildx build --platform linux/arm64 -t erdonline/erd-auth:$ERD_VERSION . --load

cd /Users/masterliang/repo/martin-framework/martin-biz/martin-biz-system
docker buildx build --platform linux/arm64 -t erdonline/erd-system:$ERD_VERSION . --load

cd /Users/masterliang/repo/martin-framework/martin-biz/martin-biz-trans
docker buildx build --platform linux/arm64 -t erdonline/erd-trans:$ERD_VERSION . --load

cd /Users/masterliang/repo/martin-framework/db
docker buildx build --platform linux/arm64 -t erdonline/erd-mysql:$ERD_VERSION . --load

cd /Users/masterliang/repo/martin-framework/elk-monitor-trace/minio
docker buildx build --platform linux/arm64 -t erdonline/erd-minio:$ERD_VERSION . --load

cd /Users/masterliang/repo/martin-framework/elk-monitor-trace/redis
docker buildx build --platform linux/arm64 -t erdonline/erd-redis:$ERD_VERSION . --load




