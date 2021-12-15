FROM whitesourcesoftware/ua-base:v2

LABEL version="1.0.1"
LABEL repository="https://github.com/TheAxZim/Whitesource-Scan-Action"
LABEL maintainer="Azeem Shezad Ilyas <azeemilyas@hotmail.com>"

RUN apt-get update \
  && apt-get -y install python3 python3-pip \
     libsasl2-dev \
     libsasl2-2 \
     libsasl2-modules-gssapi-mit \
     libldap2-dev \
     libssl-dev \
     libpq-dev \
     gcc \
     g++ \
     make \
     cmake \
     python3-dev \
  && rm -rf /var/lib/apt/lists/* \
  && pip3 install --no-cache-dir pipenv setuptools wheel poetry conda \
  && ln -s /usr/bin/python3 /usr/bin/python

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
