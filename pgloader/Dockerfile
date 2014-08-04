FROM x110dc/dev-base
#FROM ubuntu:trusty
MAINTAINER tech@texastribune.org

RUN apt-get update
RUN apt-get install -yq wget

RUN mkdir /app
RUN cd /app && wget -nv -O pgloader.deb http://pgloader.io/files/pgloader_3.0.99-1_amd64.deb && dpkg -i pgloader.deb
