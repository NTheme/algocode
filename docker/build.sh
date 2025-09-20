#! /bin/bash

set -x

localedef -v -c -i ru_RU -f UTF-8 ru_RU.UTF-8

set -e

pip install -U pip && pip install -r requirements.txt
rm -rf .git
mv configs/config_example.json configs/config.json
