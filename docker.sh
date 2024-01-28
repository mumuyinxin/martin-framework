docker-compose build

docker tag erdonline/jdk8-yum-go:latest erdonline/jdk8-yum-go:latest
docker push erdonline/jdk8-yum-go:latest


docker tag martin-extension-ncnb:latest erdonline/erd-zerocode:4.0.0-beta
docker tag martin-cloud-gateway:latest erdonline/erd-gateway:4.0.0-beta
docker tag martin-biz-auth:latest erdonline/erd-auth:4.0.0-beta
docker tag martin-biz-system:latest erdonline/erd-system:4.0.0-beta
docker tag erd-ui:latest erdonline/erd-ui:4.0.0-beta

docker push erdonline/erd-zerocode:4.0.0-beta
docker push erdonline/erd-gateway:4.0.0-beta
docker push erdonline/erd-auth:4.0.0-beta
docker push erdonline/erd-system:4.0.0-beta
docker push erdonline/erd-ui:4.0.0-beta


docker tag martin-extension-ncnb:latest erdonline/erd-zerocode:latest
docker tag martin-cloud-gateway:latest erdonline/erd-gateway:latest
docker tag martin-biz-auth:latest erdonline/erd-auth:latest
docker tag martin-biz-system:latest erdonline/erd-system:latest
docker tag erd-ui:latest erdonline/erd-ui:latest


docker push erdonline/erd-zerocode:latest
docker push erdonline/erd-gateway:latest
docker push erdonline/erd-auth:latest
docker push erdonline/erd-system:latest
docker push erdonline/erd-ui:latest
