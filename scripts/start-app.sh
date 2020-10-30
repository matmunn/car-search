#!/bin/bash -e

. "$VIRTUALENV_BASE/bin/activate"

python3 manage.py migrate
gunicorn --bind 0.0.0.0:$PORT car_search.wsgi:application
