FROM phusion/baseimage:0.10.0 
MAINTAINER rui@deniable.org

LABEL description="Base image for angr"

ENV WRKSRC /opt
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && \
  apt-get install -y build-essential vim libqt4-dev binutils-multiarch nasm libssl-dev && \
  apt-get install -y python-pip libc6 libgcc1 libstdc++6 libtinfo5 zlib1g && \
  apt-get install -y virtualenvwrapper python2.7-dev build-essential libxml2-dev libxslt1-dev git && \ 
  apt-get install -y libffi-dev cmake libreadline-dev libtool debootstrap debian-archive-keyring libglib2.0-dev libpixman-1-dev && \
  cd $WRKSRC && \
  useradd -m angr && \
  echo angr:angr | chpasswd && usermod -aG sudo angr && \
  echo 'workon angr' >> /home/angr/.bashrc && \
  git clone https://github.com/angr/angr-dev && \
  cd angr-dev && ./setup.sh -e angr && \
  cd $WRKSRC && chown -R angr:angr angr && \
  rm -rf /var/lib/apt/lists/*

USER angr
WORKDIR /home/angr
ENV HOME /home/angr
CMD ["/bin/bash"]
