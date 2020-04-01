FROM alpine as builder
RUN apk --update add alpine-sdk && \
  apk add autoconf && \
  apk add automake

COPY . /app

RUN cd /app && \
  ./autogen.sh && \
  ./configure && \
  make

FROM alpine
COPY --from=builder /app/statsd-proxy /usr/local/bin/statsd-proxy

COPY .docker/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/local/bin/statsd-proxy", "-f", "/etc/statsd-proxy.cfg"]

EXPOSE 8125/udp