FROM texastribune/supervisor
MAINTAINER tech@texastribune.org

RUN apt-get -yq install nginx
# There's a known harmless warning generated here:
# See https://github.com/benoitc/gunicorn/issues/788
RUN pip install gunicorn==19.1.1

WORKDIR /app

RUN mkdir -p /app/logs
RUN mkdir /app/run

ADD gunicorn_conf.py /app/
ADD gunicorn.supervisor.conf /etc/supervisor/conf.d/

ADD nginx.conf /app/
ADD nginx.supervisor.conf /etc/supervisor/conf.d/

VOLUME ["/app/logs"]
EXPOSE 80
