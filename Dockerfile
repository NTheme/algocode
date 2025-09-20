FROM python:slim

WORKDIR /app
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1

RUN apt update && \
    apt install -y --no-install-recommends build-essential libpq-dev libmemcached-dev && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install -U pip && pip install -r requirements.txt

COPY . .

RUN rm -rf .git

COPY docker/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["python", "manage.py", "runserver", "0.0.0.0:80"]
