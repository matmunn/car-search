#!/bin/bash -e

. "$VIRTUALENV_BASE/bin/activate"

bash -c "$*"
