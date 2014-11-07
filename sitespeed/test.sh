#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail
set -o xtrace

/etc/init.d/xvfb start

phantomjs yslow.js -i grade -t '{"overall": "C", "ycdn": "F"}' -f tap http://test-subject:8000/ > /results/yslow.tap
phantomjs yslow.js -i comps -f xml http://test-subject:8000/ > /results/yslow.xml
