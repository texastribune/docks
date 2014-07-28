FROM ubuntu:trusty
MAINTAINER tech@texastribune.org

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -yq supervisor

RUN mkdir -p /app/logs

ONBUILD ENTRYPOINT ["/usr/bin/supervisord", "-n"]
ONBUILD CMD []
