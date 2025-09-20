FROM fedora:40 AS dependencies

RUN dnf -y update && dnf -y install python3 python3-pip python3-devel gcc gcc-c++ make libmemcached-devel libpq-devel zlib-devel

RUN dnf clean all

FROM dependencies AS build

WORKDIR /app
COPY . /app
RUN sed -i "s|127.0.0.1:11211|memcached:11211|" /app/configs/config_example.json && sed -i "s|MemcachedCache|PyMemcacheCache|" /app/configs/config_example.json
RUN /app/docker/build.sh

COPY docker/entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
