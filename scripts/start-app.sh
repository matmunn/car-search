#!/bin/bash -e

python3 manage.py migrate
python3 manage.py collectstatic --noinput
gunicorn --bind 0.0.0.0:$PORT car_search.wsgi:application
