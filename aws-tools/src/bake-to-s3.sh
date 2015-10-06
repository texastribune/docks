#!/usr/bin/env bash

set -o nounset
#set -o errexit
#set -o pipefail
set -o xtrace

# SITE (to crawl) and S3_TARGET (where to put it) must be specified
# DEPTH can be specified
#
# requires awscli and wget
# AWS_* should be specified

: ${SITE}:?"SITE must be set"
: ${S3_TARGET}:?"S3_TARGET must be set"

readonly SITE=${SITE}
readonly S3_TARGET=${S3_TARGET}
readonly DEPTH=${DEPTH:-1}

mkdir /tmp/site
cd /tmp/site
wget -r ${SITE} \
 --page-requisites \
 --force-html \
 --execute robots=off \
 --no-host-directories \
 --no-verbose \
 --adjust-extension \
 --level=${DEPTH}

aws s3 sync . ${S3_TARGET}
