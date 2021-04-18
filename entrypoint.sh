#!/bin/sh -l
set -e
# Directs the action to the the Github workspace.
cd $GITHUB_WORKSPACE
# use hexo from cache
./node_modules/hexo/bin/hexo clean
#echo "Generate file ..."
./node_modules/hexo/bin/hexo generate

cd upx-dir/upx-command-dir
upx login upload ${UPX_PASSWORD}
upx info
./upx sync /public / -v
