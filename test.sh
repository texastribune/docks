#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail
set -o xtrace

/etc/init.d/xvfb start

phantomjs yslow.js -i comps -f xml http://test-subject:8000/ > /results/yslow.xml
echo $?
phantomjs yslow.js -i grade -t '{"overall": "C", "ycdn": "F"}' -f tap http://test-subject:8000/ > /results/yslow.tap
echo $?

sitespeed.io -r /results -d 0 -b firefox -u http://test-subject:8000/
echo $?
sitespeed-junit.io -r /results -o /results -l 85 -a 85
echo $?
