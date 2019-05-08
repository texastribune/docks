FROM debian:9.9

RUN apt-get update && apt-get -y install -qq supervisor

RUN mkdir -p /app/logs

ONBUILD ENTRYPOINT ["/usr/bin/supervisord", "-n"]
ONBUILD CMD []
