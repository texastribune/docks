#!/usr/bin/env bash

set -o nounset
# we don't want to stop if one job returns non-zero
#set -o errexit
set -o pipefail
set -o xtrace

YSLOW_THRESHOLDS=${YSLOW_THRESHOLDS:-'{"overall": "0",
  "yexpires": "0",
  "ydns": "0",
  "ynumreq": "30",
  "ycdn": "0",
  "ycompress": "20",
  "ymindom": "70",
  "ycookiefree": "30",
  "ynofilter": "15",
  "ycdn": "F" }'}

# we get the overall score, the response time and load time from here:
phantomjs yslow.js -i comps -f xml http://test-subject:8000/ > /results/yslow.xml
# this will exit with a non-zero code if the tests don't pass:
phantomjs yslow.js -i grade -t ${YSLOW_THRESHOLDS} -f tap http://test-subject:8000/ > /results/yslow.tap

/etc/init.d/xvfb start
export DISPLAY=:1.0

# remove any previous results
rm -r /results/test-subject
sitespeed.io -r /results -d 0 -b firefox -u http://test-subject:8000/
mv /results/test-subject/*/* /results/test-subject/

#sitespeed.io -d 0 --tap --url http://test-subject:8000 "-b chrome -n 1" > /results/sitespeed.tap
