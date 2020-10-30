#!/bin/bash -e

if [ -z "$VIRTUAL_ENV" ]; then
    if [ ! -f "$VIRTUALENV_BASE/bin/activate" ]; then
        echo "Creating virtualenv"
        virtualenv -p "$(command -v python3)" --system-site-packages "$VIRTUALENV_BASE"
    fi
    . "$VIRTUALENV_BASE/bin/activate"
fi

pipenv sync "$(test "$ENVIRONMENT" == production || echo "--dev")"
