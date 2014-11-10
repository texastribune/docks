#!/usr/bin/env bash

set -o nounset
# we don't want to stop if one job returns non-zero
#set -o errexit
set -o pipefail
set -o xtrace

# gather CL args into list of URLs:
URLS=""
for var in "$@"
do
  URLS="${URLS} http://test-subject:8000${var}"
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
# we only look at "/" because that's the only page we grab timings from:
phantomjs yslow.js -i comps -f xml http://test-subject:8000/ > /results/yslow.xml
# this will exit with a non-zero code if the tests don't pass:
for URL in "$@"
do
  short=`echo ${URL} | tr -cd [[:alpha:]]`
  if [[ $short="" ]]; then
    short="slash"
  fi
  phantomjs yslow.js -i grade -t "${YSLOW_THRESHOLDS}" -f tap test-subject:8000${URL} > /results/${short}.tap
done

/etc/init.d/xvfb start
export DISPLAY=:1.0

# remove any previous results
rm -r /results/test-subject
# if you provide multiple --url looks like it ignores all but the last so doing
# depth=1 instead:
sitespeed.io -r /results -d 1 -b firefox --url http://test-subject:8000/
mv /results/test-subject/*/* /results/test-subject/

#sitespeed.io -d 0 --tap --url http://test-subject:8000 "-b chrome -n 1" > /results/sitespeed.tap
