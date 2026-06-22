#!/bin/bash

function open_post(){
    local path
    path=$(raco frog -n "$1" 2>&1 | grep -o '/[^ ]*\.md')
    [[ -n "$path" ]] && e "$path"
}

[[ -n "$1" ]] && open_post "$1" || (echo Usage: ; echo $0 post-name 1>&2)
