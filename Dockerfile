# Force autobuild 1434570587

FROM konstruktoid/debian:wheezy

ADD https://raw.githubusercontent.com/konstruktoid/Docker/master/Security/cleanBits.sh /tmp/cleanBits.sh

RUN \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install iputils-ping && \
    apt-get -y clean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/* \
      /usr/share/doc /usr/share/doc-base \
      /usr/share/man /usr/share/locale /usr/share/zoneinfo

RUN \
    useradd --system --no-create-home --user-group --shell /bin/false dockeru && \
    /bin/bash /tmp/cleanBits.sh

CMD ["/bin/bash"]
