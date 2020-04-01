Statsd-Proxy
============

[![Build Status](https://travis-ci.org/Adgoal/statsd-proxy.svg?branch=master)](https://travis-ci.org/Adgoal/statsd-proxy)
![Docker Pulls](https://img.shields.io/docker/pulls/adgoal/statsd-proxy)
![GitHub](https://img.shields.io/github/license/adgoal/statsd-proxy)

Proxy for [etsy/statsd](https://github.com/etsy/statsd).

Why
---

[etsy/statsd](https://github.com/etsy/statsd) comes with a proxy in nodejs,
and we are running it on a single server, proxing a statsd cluster via an
udp port. But we found that this nodejs proxy is losing packets, up to
30~40% sometimes!

Cpus are idle but packets are being lost. In our case, one api call makes one
statsd request, maybe the single udp socket is too busy.

We tried to use `SO_REUSEPORT` on the original nodejs proxy, this enables
us to bind multiple udp sockets on a single port, but nodejs(or libuv) has
disabled this option, and golang just dosen't have a method `setsockopt()`.

Therefore, we made it in C.

Features
--------

* Zero dependencies.
* Very very fast.
* Multiple threading.
* Reuseport support.
* Packet aggregation.

Limitations
-----------

* Only available on linux 3.9+ (option `SO_REUSEPORT`)
* Only support udp server and udp backends.

Requirements
-------------

Linux 3.9+.

Build
------

    $ ./autogen.sh
    $ ./configure
    $ make

Usage
-----

    Usage:
      ./statsd-proxy -f ./path/to/config.cfg
    Options:
      -h, --help        Show this message
      -v, --version     Show version
      -d, --debug       Enable debug logging
    Copyright (c) https://github.com/hit9/statsd-proxy

In Docker image use env var
```text
STATSD_PORXY_PORT=9125
STATSD_PORXY_NUM_THREADS=4
STATSD_PORXY_FLUSH_INTERVAL=10 #ms
STATSD_PORXY_SOCKET_RECEIVE_BUFSIZE=106496
STATSD_PORXY_NODES="node1:9125,node2:9125,node3:9125"
```
License
-------

MIT (c) Chao Wang <hit9@github.com> 2015.
