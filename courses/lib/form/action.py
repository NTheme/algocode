import json

import requests
from django.template import Template, Context

from courses.models import FormAction


def form_action(action: FormAction, data):
    headers = json.loads(action.headers)

    body = Template(action.body).render(Context(data))
    body = json.loads(body)

    rsp = requests.post(action.url, json=body, headers=headers)