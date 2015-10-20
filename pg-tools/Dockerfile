FROM texastribune/base
MAINTAINER tech@texastribune.org

RUN apt-get update && apt-get install -y \
  curl \
  postgresql-client \
  pv \
  --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN pip install awscli postdoc

ADD . /app

ENTRYPOINT ["/bin/bash"]
