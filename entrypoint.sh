#!/bin/sh -l
set -e
# Directs the action to the the Github workspace.
cd $GITHUB_WORKSPACE
# use hexo from cache
./node_modules/hexo/bin/hexo clean
#echo "Generate file ..."
./node_modules/hexo/bin/hexo generate
mkdir -p /github/home/.upx.db
cd /github/home
git config --global user.email "github.forest10@gmail.com"
git config --global user.name "Forest10"
git clone https://${PERSONAL_TOKEN}@github.com/Forest10/my-hexo-conf.git udx-db
cd udx-db
git checkout udx-db
git pull
cp -r $GITHUB_WORKSPACE/public ./
echo $(date) >date.txt
git add -A
git commit -m '哈哈'
echo 'Start push'
git push
echo "push to udx-db-git successful!"




cp -r /github/home/udx-db  /github/home/udx-db_head
cd /github/home/udx-db_head
git reset --hard HEAD^
rsync --dry-run -rcnC --out-format="%n"  /github/home/udx-db/  /github/home/udx-db_head/ |grep -v "/$"|xargs -I{} rsync -R /github/home/udx-db/ ./{} /github/home/diff_out/


cd $GITHUB_WORKSPACE/upx-dir/upx-command-dir
./upx login ${BUCKET_NAME} ${UPX_NAME} ${UPX_PASSWORD}
./upx info
./upx sync /github/home/diff_out / -v






