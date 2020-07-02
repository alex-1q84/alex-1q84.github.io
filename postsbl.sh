#!/bin/bash
# create scribble post
[[ ! -z "$1" ]] && raco frog -N "$1" || (echo Usage: ; echo $0 post-name 1>&2)
