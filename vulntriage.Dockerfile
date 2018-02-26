FROM fdiskyou/afl:0.1
MAINTAINER rui@deniable.org

RUN dpkg --add-architecture i386 && \
apt-get update && apt-get -y upgrade && \
apt-get -y install git cmake libelf-dev libelf1 libiberty-dev libboost-all-dev && \
apt-get -y install libtool autoconf pkg-config python-dev lzma lzma-dev sudo && \ 
apt-get -y install liblzma-dev liblz-dev liblz1 valgrind valgrind-dbg gdb htop && \
apt-get -y install nasm binwalk binutils strace ltrace unzip libtool-bin screen && \
apt-get -y install python3-dev python-pip python3-pip radare2 radare2-plugins && \
git clone https://github.com/pwndbg/pwndbg.git /opt/pwndbg && cd /opt/pwndbg && ./setup.sh && \
git clone https://github.com/jfoote/exploitable.git /opt/exploitable && cd /opt/exploitable && python setup.py install && \
git clone https://github.com/slimm609/checksec.sh.git /opt/checksec && \
git clone https://github.com/OblivionDev/fuzzdiff.git /opt/fuzzdiff && cd ~/WRKSRC && \
curl -L https://github.com/DynamoRIO/dynamorio/releases/download/release_7_0_0_rc1/DynamoRIO-Linux-7.0.0-RC1.tar.gz | tar zxf - && 
apt-get -y autoremove && \
rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
