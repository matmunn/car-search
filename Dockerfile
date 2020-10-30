FROM debian:buster

RUN groupadd -r app && \
    useradd -r -g app app && \
    mkdir -p /app /virtualenv && \
    chown -R app: /app /virtualenv

WORKDIR /app
COPY . .

ENV VIRTUALENV_BASE "/virtualenv"

RUN set -ex && \
    curl -sL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -  && \
    echo 'deb http://deb.nodesource.com/node_12.x buster main' > /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends nodejs python3 && \
    pip3 install pipenv && \
    ./scripts/install-deps.sh && \
    rm -rf /var/lib/apt/lists/*

CMD gunicorn --bind 0.0.0.0:$PORT car_search.wsgi:application
