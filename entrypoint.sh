#!/bin/sh -l
set -e
# Directs the action to the the Github workspace.
cd $GITHUB_WORKSPACE
# use hexo from cache
./node_modules/hexo/bin/hexo clean
#echo "Generate file ..."
./node_modules/hexo/bin/hexo generate
###判断.upx.db存在?
# 设置用户名mail
git config user.name "Forest10"
git config user.email "github.forest10@gmail.com"
git clone https://$PERSONAL_TOKEN@github.com/Forest10/my-hexo-conf.git udx-db
cd udx-db
UDX_DB_GIT_DIR=$(pwd)
git checkout udx-db
git pull
UDX_DB_HOME=/home/runner/work/_temp/_github_home/.upx.db
if [ -d ${UDX_DB_HOME} ];then
  echo "文件夹存在"
  # shellcheck disable=SC2035
  cp -r * ${UDX_DB_HOME}
  else
  echo "文件夹不存在,新建"
  mkdir -p ${UDX_DB_HOME}
  cp -r "${UDX_DB_GIT_DIR}" ${UDX_DB_HOME}
  cd  ${UDX_DB_HOME} && ls
fi


cd $GITHUB_WORKSPACE/upx-dir/upx-command-dir
./upx login ${BUCKET_NAME} ${UPX_NAME} ${UPX_PASSWORD}
./upx info
./upx sync $GITHUB_WORKSPACE/public / -v
## add upx.db to upx.db git
cp -r ${UDX_DB_HOME} ${UDX_DB_GIT_DIR}
cd ${UDX_DB_GIT_DIR}
echo $(date) >date.txt
git add -A
git commit -m '哈哈'
echo 'Start push'
git push

echo "push to udx-db-git successful!"



