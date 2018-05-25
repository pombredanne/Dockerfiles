FROM ubuntu:trusty
MAINTAINER rui@deniable.org

LABEL description="Base image for angr"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \ 
  apt-get install -y virtualenvwrapper python2.7-dev build-essential libxml2-dev libxslt1-dev git && \
  apt-get install -y libffi-dev cmake libreadline-dev libtool debootstrap debian-archive-keyring && \
  apt-get install -y libglib2.0-dev libpixman-1-dev && \
  useradd -s /bin/bash -m angr && \
  su - angr -c "git clone https://github.com/angr/angr-dev && cd angr-dev && ./setup.sh -e angr" && \
  su - angr -c "echo 'workon angr' >> /home/angr/.bashrc" && \

CMD ["su - angr"]
