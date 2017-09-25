#!/bin/sh
while inotifywait -e modify,close_write,create,delete -rq ~/tqtc-coin-ci; do
 ~/sync-to-remote/sync-to-remote quiet
done
