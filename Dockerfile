FROM debian:latest

ADD https://raw.githubusercontent.com/konstruktoid/Docker/master/Security/cleanBits.sh /tmp/cleanBits.sh

RUN \
	apt-get update && \
	apt-get -y upgrade && \
	apt-get -y clean && \
	apt-get -y autoremove

RUN \
	useradd --system --no-create-home --user-group --shell /bin/false dockeru && \
	/bin/bash /tmp/cleanBits.sh

CMD ["bash"]
