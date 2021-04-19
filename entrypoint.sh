#!/bin/sh -l

set -e



if [ -z "$PERSONAL_TOKEN" ]; then
  echo "You must provide the action with either a Personal Access Token or the GitHub Token secret in order to deploy."
  exit 1
fi

# Directs the action to the the Github workspace.
cd $GITHUB_WORKSPACE
# use hexo from cache
./node_modules/hexo/bin/hexo clean
#echo "Generate file ..."
./node_modules/hexo/bin/hexo generate

#### 用git diff搞定差异文件
UDX_DB_DIR=$GITHUB_WORKSPACE/udx-db
git config --global user.email "github.forest10@gmail.com"
git config --global user.name "Forest10"
git clone https://${PERSONAL_TOKEN}@github.com/Forest10/my-hexo-conf.git $UDX_DB_DIR
cd $UDX_DB_DIR
git checkout udx-db
git pull
cp -r $GITHUB_WORKSPACE/public/* $UDX_DB_DIR
git add -A
git commit -m 'push by hexo-deploy-upyun-action'
git push
echo "push to udx-db-git successful!"
git pull
UPDATE_BLOG_FILE=$GITHUB_WORKSPACE/public/update_blog_file
mkdir -p $UPDATE_BLOG_FILE
git diff  HEAD^ HEAD --name-only|sed 's/\"//g' >> diff.txt
lineLiner="/"
for i in $(cat diff.txt); do
fileName=${i}
result=$(echo $fileName | grep "${lineLiner}")
if [ "$result" != "" ]
then
    cutFilePath=${fileName%/*}
    mkdir -p ${des}/${cutFilePath}
    cp -r -n ${UDX_DB_DIR}/${fileName} ${UPDATE_BLOG_FILE}/${cutFilePath};
else
    cp -r -n ${UDX_DB_DIR}/${fileName} ${UPDATE_BLOG_FILE};
fi
done
echo 'UPDATE_BLOG_FILE===>'
cd ${UPDATE_BLOG_FILE} && ls
## 执行upx upload
#cd $GITHUB_WORKSPACE/upx-dir/upx-command-dir
#./upx login ${BUCKET_NAME} ${UPX_NAME} ${UPX_PASSWORD}
#echo "start upx upload!"
#./upx sync ${UPDATE_BLOG_FILE} / -v
#echo "upx upload successful!"
#






