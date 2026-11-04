#!/bin/bash

git checkout gh-pages

#清除当前库中未提交的变更
git reset --hard
#清除本地库中构建过程生成的中间产物
git clean -dqxf
#同步远端 gh-pages（Actions 发布会重写其历史，需重置到远端最新提交）
git fetch origin
git reset --hard origin/gh-pages
git merge --no-ff --log master -m "git merge origin/master"

if [ $? -eq '0' ]; then
    make build
    git add -A -f .
    git commit -m "`date +%Y%m%d%H%M%S` generate post pages"
    git push
    echo "push to remote"
else
    echo "merge failed, cancel push" 1>&2
fi

