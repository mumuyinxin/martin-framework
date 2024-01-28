

ips=('martin-biz-resource' 'martin-biz-sso' 'martin-biz-swagger' 'martin-biz-system')

#for ip in ${ips[@]}
#do
#  echo `开始创建项目：${ip}`
#  git clone ~/repo/martin.origin ~/repo/${ip}
#  cd ~/repo/${ip}
#  git filter-repo --subdirectory-filter martin-biz/${ip}
#  git remote add origin git@github.com:www-zerocode-net-cn/${ip}.git
#  git branch -M main
#  git push -u origin main
#  echo `结束创建项目：${ip}`
#done



for ip in ${ips[@]}
do
  echo '开始创建子模块：'${ip}
  cd ~/repo/martin-framework/martin-biz
  git submodule add git@github.com:www-zerocode-net-cn/${ip}.git ${ip}
  echo `结束创建子模块：${ip}`
done

