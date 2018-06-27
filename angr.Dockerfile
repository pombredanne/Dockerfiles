FROM ubuntu:trusty
MAINTAINER rui@deniable.org

LABEL description="Base image for angr"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update &&                 \
  apt-get install -y virtualenvwrapper python2.7-dev build-essential libxml2-dev libxslt1-dev git libffi-dev cmake libreadline-dev libtool debootstrap debian-archive-keyring libglib2.0-dev libpixman-1-dev

RUN useradd -s /bin/bash -m angr
RUN su - angr -c "git clone https://github.com/angr/angr-dev && cd angr-dev && ./setup.sh -e angr"
RUN su - angr -c "echo 'workon angr' >> /home/angr/.bashrc"

CMD ["su - angr"]
