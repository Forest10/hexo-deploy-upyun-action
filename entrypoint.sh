#!/bin/sh -l
set -e
# Directs the action to the the Github workspace.
cd $GITHUB_WORKSPACE
# use hexo from cache
./node_modules/hexo/bin/hexo clean
#echo "Generate file ..."
./node_modules/hexo/bin/hexo generate
###判断.upx.db存在?
mkdir -p  /home/runner/work/_temp/_github_home/.upx.db
cd /home/runner/work/_temp/_github_home/
git clone https://${PERSONAL_TOKEN}@github.com/Forest10/my-hexo-conf.git udx-db
cd udx-db
git checkout udx-db
git pull
cp /home/runner/work/_temp/_github_home/udx-db/*  /home/runner/work/_temp/_github_home/.upx.db

cd $GITHUB_WORKSPACE/upx-dir/upx-command-dir
./upx login ${BUCKET_NAME} ${UPX_NAME} ${UPX_PASSWORD}
./upx info
./upx sync $GITHUB_WORKSPACE/public / -v





