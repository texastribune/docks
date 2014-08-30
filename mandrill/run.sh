#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail

sed -i "s/MANDRILL_USERNAME/${MANDRILL_USERNAME}/g" /etc/postfix/sasl_passwd
sed -i "s/MANDRILL_API_KEY/${MANDRILL_API_KEY}/g" /etc/postfix/sasl_passwd

/usr/sbin/postmap /etc/postfix/sasl_passwd

/usr/bin/supervisord
