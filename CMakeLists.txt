cmake_minimum_required(VERSION 2.6)

project(statsd-proxy)

find_package (Threads)
set(SOURCES src/buf.c src/cfg.c src/config.c src/ctx.c src/event.c src/ketama.c src/log.c src/md5.c src/parser.c src/proxy.c src/statsd-proxy.c)
add_executable(statsd-proxy ${SOURCES})
target_link_libraries(statsd-proxy pthread )

# включаем CTest
enable_testing()