#FROM x110dc/dev-base
FROM phusion/baseimage
MAINTAINER tech@texastribune.org

RUN apt-get update

RUN apt-get install -y postfix supervisor libsasl2-modules syslog-ng-core

# http://help.mandrill.com/entries/23060367-Can-I-configure-Postfix-to-send-through-Mandrill-

ENV MANDRILL_USERNAME MANDRILL_USERNAME
ENV MANDRILL_API_KEY MANDRILL_KEY

ADD sasl_passwd /etc/postfix/
ADD main.cf /etc/postfix/
ADD run.sh /
ADD postfix-supervisord.conf /etc/supervisor/conf.d/postfix.conf
ADD syslog-ng-supervisor.conf /etc/supervisor/conf.d/syslog-ng.conf
ADD syslog-ng.conf /etc/syslog-ng/syslog-ng.conf
ADD supervisord.conf /etc/supervisor/

VOLUME /var/log

CMD /run.sh

CMD ["/sbin/my_init"]

EXPOSE 25
