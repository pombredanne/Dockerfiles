FROM ubuntu:trusty 
MAINTAINER rui@deniable.org

LABEL description="Base image for angr"

ENV WRKSRC /opt
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && \
  apt-get install -y build-essential vim virtualenvwrapper python2.7-dev build-essential libxml2-dev libxslt1-dev git libffi-dev cmake libreadline-dev libtool debootstrap debian-archive-keyring libglib2.0-dev libpixman-1-dev && \
  cd $WRKSRC && \
  git clone https://github.com/angr/angr-dev && \
  cd angr-dev && ./setup.sh -e angr && \
  useradd -m angr && \
  echo angr:angr | chpasswd && usermod -aG sudo angr && \
  cd $WRKSRC && chown -R angr:angr angr && \
  echo 'workon angr' >> /home/angr/.bashrc && \
  rm -rf /var/lib/apt/lists/*

USER angr
WORKDIR /home/angr
ENV HOME /home/angr
CMD ["/bin/bash"]
