#!/bin/sh -l

set -e

# Directs the action to the the Github workspace.
cd $GITHUB_WORKSPACE
#
#echo "npm install ..."
#npm install
#echo "Clean folder ..."
./node_modules/hexo/bin/hexo clean
#echo "Generate file ..."
./node_modules/hexo/bin/hexo generate

 ls
