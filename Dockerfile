FROM python:slim AS dependencies

RUN apt update && apt install -y --no-install-recommends build-essential libpq-dev libmemcached-dev zlib1g-dev

RUN rm -rf /var/lib/apt/lists/*

FROM dependencies AS build

WORKDIR /app
COPY . /app

RUN /app/docker/build.sh

COPY docker/entrypoint.sh /

ENTRYPOINT ["/app/entrypoint.sh"]
