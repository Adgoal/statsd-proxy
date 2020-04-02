FROM alpine as builder
RUN apk --no-cache add cmake clang clang-dev make gcc g++ libc-dev linux-headers

COPY . /app

RUN cd /app && \
    cmake -DCMAKE_BUILD_TYPE=Release && \
    cmake --build .

FROM alpine
COPY --from=builder /app/statsd-proxy /usr/local/bin/statsd-proxy

COPY .docker/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/local/bin/statsd-proxy", "-f", "/etc/statsd-proxy.cfg"]