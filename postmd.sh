#!/bin/bash

[[ ! -z "$1" ]] && raco frog -n "$1" || (echo Usage: ; echo $0 post-name 1>&2)
