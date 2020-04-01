#!/usr/bin/env sh

set -e

STATSD_PORXY_PORT="${STATSD_PORXY_PORT:-9125}"
STATSD_PORXY_NUM_THREADS="${STATSD_PORXY_NUM_THREADS:-4}"
STATSD_PORXY_FLUSH_INTERVAL="${STATSD_PORXY_FLUSH_INTERVAL:-10}"
STATSD_PORXY_SOCKET_RECEIVE_BUFSIZE="${STATSD_PORXY_SOCKET_RECEIVE_BUFSIZE:-106496}"
STATSD_PORXY_NODES=""

echo '' > /etc/statsd-proxy.cfg # set config file is empty
echo -e "port ${STATSD_PORXY_PORT}" >> /etc/statsd-proxy.cfg
echo -e "num_threads ${STATSD_PORXY_NUM_THREADS}" >> /etc/statsd-proxy.cfg
echo -e "flush_interval ${STATSD_PORXY_FLUSH_INTERVAL}" >> /etc/statsd-proxy.cfg
echo -e "socket_receive_bufsize ${STATSD_PORXY_SOCKET_RECEIVE_BUFSIZE}" >> /etc/statsd-proxy.cfg

nodes=$(echo $STATSD_PORXY_NODES | tr "," "\n")

for host in $nodes
do
    echo -e "node $host:1" >> /etc/statsd-proxy.cfg
done

echo
echo 'statsd-proxy init process done. Ready for start up.'
echo

exec "$@"
