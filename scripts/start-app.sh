#!/bin/bash -e

. "$VIRTUALENV_BASE/bin/activate"

python3 manage.py migrate
python3 manage.py collectstatic --noinput
gunicorn --bind 0.0.0.0:$PORT car_search.wsgi:application
