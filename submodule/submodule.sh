git clone ~/repo/martin.origin ~/repo/martin-biz-system
cd ~/repo/martin-biz-system
git filter-repo --subdirectory-filter martin-biz/martin-biz-system
git remote add origin git@github.com:www-zerocode-net-cn/martin-biz-system.git
git branch -M main
git push -u origin main


git clone ~/repo/martin.origin ~/repo/martin-cloud-gateway
cd ~/repo/martin-cloud-gateway
git filter-repo --subdirectory-filter martin-cloud/martin-cloud-gateway
git remote add origin git@github.com:www-zerocode-net-cn/martin-cloud-gateway.git
git branch -M main
git push -u origin main


git clone ~/repo/martin.origin ~/repo/martin-common
cd ~/repo/martin-common
git filter-repo  --path pom.xml
git remote add origin git@github.com:www-zerocode-net-cn/martin-common.git
git branch -M main
git push -u origin main

git clone ~/repo/martin.origin ~/repo/martin-common-api
cd ~/repo/martin-common-api
git filter-repo --subdirectory-filter martin-common/martin-common-api
git remote add origin git@github.com:www-zerocode-net-cn/martin-common-api.git
git branch -M main
git push -u origin main



git clone ~/repo/martin.origin ~/repo/martin-common-bean
cd ~/repo/martin-common-bean
git filter-repo --subdirectory-filter martin-common/martin-common-bean
git remote add origin git@github.com:www-zerocode-net-cn/martin-common-bean.git
git branch -M main
git push -u origin main



git clone ~/repo/martin.origin ~/repo/martin-common-bom
cd ~/repo/martin-common-bom
git filter-repo --subdirectory-filter martin-common/martin-common-bom
git remote add origin git@github.com:www-zerocode-net-cn/martin-common-bom.git
git branch -M main
git push -u origin main




git clone ~/repo/martin.origin ~/repo/martin-spring-boot-starter
cd ~/repo/martin-spring-boot-starter
git filter-repo --subdirectory-filter martin-spring-boot-starter
git remote add origin git@github.com:www-zerocode-net-cn/martin-spring-boot-starter.git
git branch -M main
git push -u origin main



git clone ~/repo/martin.origin ~/repo/martin-biz
cd ~/repo/martin-biz
git filter-repo  --path pom.xml
git remote add origin git@github.com:www-zerocode-net-cn/martin-biz.git
git branch -M main
git push -u origin main


git clone ~/repo/martin.origin ~/repo/martin-cloud
cd ~/repo/martin-cloud
git filter-repo  --path pom.xml
git remote add origin git@github.com:www-zerocode-net-cn/martin-cloud.git
git branch -M main
git push -u origin main


git clone ~/repo/martin.origin ~/repo/martin-extension
cd ~/repo/martin-extension
git filter-repo  --path pom.xml
git remote add origin git@github.com:www-zerocode-net-cn/martin-extension.git
git branch -M main
git push -u origin main


git clone ~/repo/martin.origin ~/repo/martin-framework
cd ~/repo/martin-framework
git filter-repo --path-glob 'martin-*' --invert-paths
git remote add origin git@github.com:www-zerocode-net-cn/martin-framework.git
git branch -M main
git push -u origin main


