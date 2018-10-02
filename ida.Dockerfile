FROM ubuntu:18.04
MAINTAINER rui@deniable.org

# check https://hub.docker.com/u/fdiskyou/ for more information
ENV WRKSRC /opt
ENV DEBIAN_FRONTEND noninteractive
ENV DISPLAY :0
ENV QT_X11_NO_MITSHM 1
ENV PYTHONPATH /usr/local/lib/python2.7/dist-packages/

RUN dpkg --add-architecture i386 && \
apt-get update && apt-get -y upgrade && \
apt-get -y install git vim cmake libelf-dev libelf1 libiberty-dev libboost-all-dev libtool pkg-config python-dev lzma \
  lzma-dev sudo liblzma-dev liblz-dev liblz1 autoconf gdb htop nasm binwalk binutils strace ltrace unzip libtool-bin \
  screen python3-dev python-pip python3-pip wget libc6:i386 libncurses5:i386 libstdc++6:i386 \
  libc6-dev-i386 libini-config-dev python-pyqt5 ipython \
  libxext6:i386 libxrender1:i386 libglib2.0-0:i386 libfontconfig1:i386 libsm6:i386 libfreetype6:i386 libglib2.0-0:i386 && \
apt-get -qy clean autoremove && \
rm -rf /var/lib/apt/lists/*

# most of the times I need this... have a look at http://www.hexblog.com/?p=726 
#RUN cd $WRKSRC && git clone https://github.com/andreafioraldi/IDAngr
#RUN pip install rpyc && pip install appdirs && pip install angrdbg

RUN export uid=1000 gid=1000 && \
  mkdir -p /home/idauser && \
  echo "idauser:x:${uid}:${gid}:Developer,,,:/home/idauser:/bin/bash" >> /etc/passwd && \
  echo "idauser:x:${uid}:" >> /etc/group && \
  echo "idauser ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/idauser && \
  chmod 0440 /etc/sudoers.d/idauser && \
  chown ${uid}:${gid} -R /home/idauser

USER idauser
ENV HOME /home/idauser
CMD ["/bin/bash"]
