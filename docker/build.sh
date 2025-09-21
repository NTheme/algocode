#! /bin/bash

set -x

localedef -v -c -i ru_RU -f UTF-8 ru_RU.UTF-8

set -e

#RELEASE=
RELEASE='RELEASE=1'

rm -rf .git
sed -i "s|MemcachedCache|PyMemcacheCache|" /app/configs/config_example.json
sed -i "s|127.0.0.1:11211|memcached:11211|" /app/configs/config_example.json
sed -i "s|"connection_string": ""|"connection_string": "127.0.0.1:27017"|"
sed -i "s|http://some_ejudge_url.com|http://ejudge-net|" /app/configs/config_example.json
sed -i "s|ejudge_admin_login|ejudge|" /app/configs/config_example.json
sed -i "s|ejudge_admin_password|ejudge|" /app/configs/config_example.json
sed -i "s|<path to ejudge bin/serve-control>|/home/judges/bin/ejudge-control|" /app/configs/config_example.json

pip install -U pip && pip install -r requirements.txt pymemcache
mv configs/config_example.json configs/config.json
