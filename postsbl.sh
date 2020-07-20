#!/bin/bash
# create scribble post
function creat_and_open(){
    emacs $(raco frog -N "$1" | egrep -o "[^ ]+$1[^ ]+")
}

[[ ! -z "$1" ]] && creat_and_open "$1" || (echo Usage: ; echo $0 post-name 1>&2)
