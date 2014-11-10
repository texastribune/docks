#!/usr/bin/env bash

set -o nounset
# we don't want to stop if one job returns non-zero
#set -o errexit
set -o pipefail
set -o xtrace

# gather CL args into list of URLs:
URLS=""
SITESPEED_URLS=""
for var in "$@"
do
  URLS="${URLS} http://test-subject:8000${var}"
  SITESPEED_URLS="${SITESPEED_URLS} -u http://test-subject:8000${var}"
done

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
phantomjs yslow.js -i comps -f xml ${URLS} > /results/yslow.xml
# this will exit with a non-zero code if the tests don't pass:
for URL in "$@"
do
  short=`echo ${URL} | tr -cd [[:alpha:]]`
  phantomjs yslow.js -i grade -t "${YSLOW_THRESHOLDS}" -f tap test-subject:8000${URL} > /results/${short}.tap
done

/etc/init.d/xvfb start
export DISPLAY=:1.0

# remove any previous results
rm -r /results/test-subject
sitespeed.io -r /results -d 0 -b firefox ${SITESPEED_URLS}
mv /results/test-subject/*/* /results/test-subject/

#sitespeed.io -d 0 --tap --url http://test-subject:8000 "-b chrome -n 1" > /results/sitespeed.tap
