#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail
set -o xtrace

readonly filename=/tmp/pg.dump

aws s3 cp ${S3_SOURCE} ${filename}

TEMPLATE_DB=$(dirname ${DATABASE_URL})/template_db

phd TEMPLATE_DB dropdb --if-exists
phd TEMPLATE_DB createdb
phd TEMPLATE_DB pg_restore --no-owner --no-acl --format=custom ${filename}

phd dropdb
phd createdb --template=template_db
