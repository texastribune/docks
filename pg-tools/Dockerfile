FROM texastribune/base
MAINTAINER tech@texastribune.org

RUN apt-get update && apt-get install -y \
  curl \
  postgresql-client \
  pv

RUN pip install --quiet awscli postdoc

ADD . /app

ENTRYPOINT ["/bin/bash"]
