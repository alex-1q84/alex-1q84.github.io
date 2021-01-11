#!/bin/bash

git checkout gh-pages
git merge --no-ff --log master -m "git merge origin/master"
<<<<<<< HEAD
#git push
=======
git push
>>>>>>> master
