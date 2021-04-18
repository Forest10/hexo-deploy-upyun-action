#!/bin/sh -l
set -e
# Directs the action to the the Github workspace.
cd $GITHUB_WORKSPACE
# use hexo from cache
./node_modules/hexo/bin/hexo clean
#echo "Generate file ..."
./node_modules/hexo/bin/hexo generate



cd upx-dir/upx-command-dir
./upx login ${BUCKET_NAME} ${UPX_NAME} ${UPX_PASSWORD}
./upx info
cp -r  $GITHUB_WORKSPACE/upx-dir/upx-db /home/runner/work/_temp/_github_home/.upx.db
./upx sync $GITHUB_WORKSPACE/public / -v
cp -r /home/runner/work/_temp/_github_home/.upx.db $GITHUB_WORKSPACE/upx-dir/upx-db


