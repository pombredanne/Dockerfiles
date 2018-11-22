FROM ubuntu:18.04
MAINTAINER rui@deniable.org

# check https://hub.docker.com/u/fdiskyou/ for more information
ENV WRKSRC /opt
ENV DEBIAN_FRONTEND noninteractive
ENV DISPLAY :0
ENV QT_X11_NO_MITSHM 1

RUN apt-get update && apt-get -y upgrade && \
apt-get -y install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev && \
apt-get -y install zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev ruby bundler && \ 
apt-get -qy clean autoremove && \
rm -rf /var/lib/apt/lists/*

RUN export uid=1000 gid=1000 && \
  mkdir -p /home/user && \
  echo "user:x:${uid}:${gid}:Developer,,,:/home/user:/bin/bash" >> /etc/passwd && \
  echo "user:x:${uid}:" >> /etc/group && \
  echo "user ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/user && \
  chmod 0440 /etc/sudoers.d/user && \
  chown ${uid}:${gid} -R /home/user

USER user
ENV HOME /home/user
CMD ["/bin/bash"]
