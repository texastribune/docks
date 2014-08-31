#!/usr/bin/env bash
#
# WIP just to get this thing working. would be nice not to need this shell script hack
#
/usr/sbin/sputnik -s
tail -f /var/log/sputnik.log
