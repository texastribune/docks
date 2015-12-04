FROM texastribune/base
MAINTAINER tech@texastribune.org

RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
RUN apt-get install -yq wget ca-certificates
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update
RUN apt-get install -yq postgresql-9.4 curl

#RUN apt-get update && apt-get install -y \
#  curl \
#  postgresql-client \
#  pv \
#  --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN pip install awscli postdoc

ADD . /app

ENTRYPOINT ["/bin/bash"]
