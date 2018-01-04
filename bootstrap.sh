#!/bin/sh

fluentd -c /etc/fluentd.conf &

exec /docker-entrypoint.sh $@
