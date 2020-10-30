#!/bin/bash -e

. "$VIRTUALENV_BASE/bin/activate"

gunicorn --bind 0.0.0.0:$PORT car_search.wsgi:application
