FROM fdiskyou/afl-dyninst:0.1 
MAINTAINER rui@deniable.org

# check https://hub.docker.com/u/fdiskyou/ for more information
ENV WRKSRC /opt
ENV DEBIAN_FRONTEND noninteractive

RUN dpkg --add-architecture i386 && \
apt-get update && apt-get -y upgrade && \
apt-get -y install git cmake libelf-dev libelf1 libiberty-dev libboost-all-dev libtool autoconf \
  pkg-config python-dev lzma lzma-dev sudo liblzma-dev liblz-dev liblz1 valgrind valgrind-dbg \
  gdb htop nasm binwalk binutils strace ltrace unzip libtool-bin screen python3-dev python-pip \
  python3-pip radare2 radare2-plugins wget libc6:i386 libncurses5:i386 libstdc++6:i386 \
  libc6-dev-i386 libini-config-dev curl \
  libxext6:i386 libxrender1:i386 libglib2.0-0:i386 libfontconfig1:i386 libsm6:i386 libfreetype6:i386 libglib2.0-0:i386 && \
pip install angrgdb pycipher uncompyle ropgadget distorm3 filebytes r2pipe && \
pip install docopt python-constraint && \
pip install capstone keystone-engine unicorn && \
git clone https://github.com/pwndbg/pwndbg.git $WRKSRC/pwndbg && cd $WRKSRC/pwndbg && ./setup.sh && \
git clone https://github.com/jfoote/exploitable.git $WRKSRC/exploitable && cd $WRKSRC/exploitable && python setup.py install && \
git clone https://github.com/fuzzamos/checksec.sh.git $WRKSRC/checksec && \
git clone https://github.com/longld/peda.git $WRKSRC/peda && \
git clone https://github.com/niklasb/libc-database $WRKSRC/libc-database && \
git clone https://github.com/hellman/xortool.git $WRKSRC/xortool && cd $WRKSRC/xortool && python setup.py install && \
git clone https://github.com/zardus/preeny.git $WRKSRC/preeny && cd $WRKSRC/preeny && make && \
git clone https://github.com/packz/ropeme.git $WRKSRC/ropeme && sed -i 's/distorm/distorm3/g' $WRKSRC/ropeme/ropeme/gadgets.py && \
git clone https://github.com/sashs/Ropper.git $WRKSRC/ropper && cd $WRKSRC/ropper && python setup.py install && cd && rm -rf $WRKSRC/ropper && \
git clone https://github.com/fuzzamos/fuzzdiff.git $WRKSRC/fuzzdiff && cd $WRKSRC && \
curl -L https://github.com/DynamoRIO/dynamorio/releases/download/release_7_0_0_rc1/DynamoRIO-Linux-7.0.0-RC1.tar.gz | tar zxf - && \ 
mkdir -p $WRKSRC/rp && wget https://github.com/downloads/0vercl0k/rp/rp-lin-x64 -P $WRKSRC/rp && \
wget https://github.com/downloads/0vercl0k/rp/rp-lin-x86 -P $WRKSRC/rp && \
wget -O ~/.gdbinit-gef.py -q https://github.com/hugsy/gef/raw/master/gef.py && \
echo source ~/.gdbinit-gef.py >> ~/.gdbinit && \
echo "set follow-fork-mode child" >> ~/.gdbinit && \
echo "set disassembly-flavor intel" >> ~/.gdbinit && \
echo "source /opt/pwndbg/gdbinit.py" >> ~/.gdbinit && \
echo "dir /usr/src/glibc/glibc-2.26/malloc" >> ~/.gdbinit && \
echo "python import angrgdb.commands" >> ~/.gdbinit && \
apt-get -qy clean autoremove && \
rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
