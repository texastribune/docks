FROM texastribune/base
MAINTAINER tech@texastribune.org

RUN apt-get install -yq supervisor

RUN mkdir -p /app/logs

ADD supervisord.conf /etc/supervisor/

ONBUILD ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
ONBUILD CMD []
