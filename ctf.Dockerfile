FROM fdiskyou/afl-dyninst:0.1 
MAINTAINER rui@deniable.org

ENV DEBIAN_FRONTEND noninteractive

RUN dpkg --add-architecture i386 && \
apt-get update && apt-get -y upgrade && \
apt-get -y install git cmake libelf-dev libelf1 libiberty-dev libboost-all-dev && \
apt-get -y install libtool autoconf pkg-config python-dev lzma lzma-dev sudo && \ 
apt-get -y install liblzma-dev liblz-dev liblz1 valgrind valgrind-dbg gdb htop && \
apt-get -y install nasm binwalk binutils strace ltrace unzip libtool-bin screen && \
apt-get -y install python3-dev python-pip python3-pip radare2 radare2-plugins && \
apt-get -y install libc6:i386 libncurses5:i386 libstdc++6:i386 libc6-dev-i386 libini-config-dev && \
pip install pycipher uncompyle ropgadget distorm3 filebytes r2pipe && \
pip install --upgrade pwntools && pip install docopt python-constraint && \
git clone https://github.com/pwndbg/pwndbg.git /opt/pwndbg && cd /opt/pwndbg && ./setup.sh && \
git clone https://github.com/jfoote/exploitable.git /opt/exploitable && cd /opt/exploitable && python setup.py install && \
git clone https://github.com/fuzzamos/checksec.sh.git /opt/checksec && \
git clone https://github.com/longld/peda.git /opt/peda && \
git clone https://github.com/niklasb/libc-database /opt/libc-database && \
git clone https://github.com/hellman/xortool.git /opt/xortool && cd /opt/xortool && python setup.py install && \
git clone https://github.com/zardus/preeny.git /opt/preeny && cd /opt/preeny && make && \
git clone https://github.com/packz/ropeme.git /opt/ropeme && sed -i 's/distorm/distorm3/g' /opt/ropeme/ropeme/gadgets.py && \
git clone https://github.com/sashs/Ropper.git /opt/ropper && cd /opt/ropper && python setup.py install && rm -rf /opt/ropper && \
git clone https://github.com/aquynh/capstone.git /opt/capstone && cd /opt/capstone && ./make.sh && ./make.sh install  && \
cd bindings/python && make install && make install3 && \
git clone https://github.com/fuzzamos/fuzzdiff.git /opt/fuzzdiff && cd ~/WRKSRC && \
curl -L https://github.com/DynamoRIO/dynamorio/releases/download/release_7_0_0_rc1/DynamoRIO-Linux-7.0.0-RC1.tar.gz | tar zxf - && \ 
mkdir -p /opt/rp && wget https://github.com/downloads/0vercl0k/rp/rp-lin-x64 -P /opt/rp && \
wget https://github.com/downloads/0vercl0k/rp/rp-lin-x86 -P /opt/rp && \
apt-get -y autoremove && \
rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
