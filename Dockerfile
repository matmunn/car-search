FROM nikolaik/python-nodejs:python3.8-nodejs12

USER root

RUN groupadd -r app && \
    useradd -r -g app app && \
    mkdir -p /app /virtualenv && \
    chown -R app: /app /virtualenv

WORKDIR /app
COPY . .

ENV VIRTUALENV_BASE="/virtualenv" \
    DEBIAN_FRONTEND=noninteractive

RUN pip3 install pipenv && \
    ./scripts/install-deps.sh

USER app

CMD ./scripts/start-app.sh
