FROM texastribune/base
MAINTAINER tech@texastribune.org

RUN apt-get install -yq postgresql-client pv > /dev/null
RUN pip install --quiet awscli postdoc

ADD . /app

ENTRYPOINT ["/bin/bash"]

CMD ["/app/export-pg-db-to-s3.sh"]
