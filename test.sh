#!/usr/bin/env bash

set -o nounset
# we don't want to stop if one job returns non-zero
#set -o errexit
set -o pipefail
set -o xtrace

/etc/init.d/xvfb start

phantomjs yslow.js -i comps -f xml http://test-subject:8000/ > /results/yslow.xml
# this will exit with a non-zero code if the tests don't pass:
phantomjs yslow.js -i grade -t '{"overall": "C", "ycdn": "F"}' -f tap http://test-subject:8000/ > /results/yslow.tap

export DISPLAY=:1.0
#sitespeed.io -r /results -d 0 -b firefox -u http://test-subject:8000/

sitespeed.io -d 0 --junit --url http://test-subject:8000 "-b chrome -n 1" > /results/sitespeed.xml
