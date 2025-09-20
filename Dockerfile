FROM fedora:40 AS dependencies

RUN dnf -y update && dnf -y install python3 python3-pip python3-devel gcc gcc-c++ make libmemcached-devel postgresql-devel zlib-devel

RUN dnf clean all

FROM dependencies AS build

WORKDIR /app
COPY . /app

RUN /app/docker/build.sh

COPY docker/entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
