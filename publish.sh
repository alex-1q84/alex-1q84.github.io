#!/bin/bash

git checkout gh-pages

#清除当前库中未提交的变更
git reset --hard
#清除本地库中构建过程生成的中间产物
git clean -dqxf
git pull
git merge --no-ff --log master -m "git merge origin/master"
##git push
