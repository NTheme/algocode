#!/bin/sh
set -e

python3 manage.py migrate --noinput

python3 manage.py shell <<'PY'
import json, os
from django.contrib.auth import get_user_model

cfg = json.load(open("/app/configs/config.json"))
su = cfg.get("secrets", {}).get("ejudge", {})
username = su.get("login", "admin")
password = su.get("password", "admin")

User = get_user_model()
u, created = User.objects.get_or_create(
    username=username,
    defaults={"is_staff": True, "is_superuser": True}
)

if created:
    u.set_password(password)
    u.save()
PY

python3 manage.py runserver 0.0.0.0:80
