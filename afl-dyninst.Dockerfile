FROM fdiskyou/afl:0.1
MAINTAINER rui@deniable.org

RUN apt-get update && apt-get -y upgrade && \
apt-get -y install git cmake libelf-dev libelf1 libiberty-dev libboost-all-dev && \
cd ~/WRKSRC && cd afl-* && ln -s afl-analyze afl && cd ~/WRKSRC && \
curl -L https://github.com/dyninst/dyninst/archive/v9.3.2.tar.gz | tar zxf - && \
cd dyninst-9.3.2 && mkdir build && cd build && cmake .. && make && make install && \
cd ~/WRKSRC && git clone https://github.com/talos-vulndev/afl-dyninst.git && \
cd afl-dyninst && ln -s `ls -1d ~/WRKSRC/afl-* | head -1` afl && make && \
cp afl-dyninst /usr/local/bin && \
cp libAflDyninst.so /usr/local/lib && \
echo "/usr/local/lib" > /etc/ld.so.conf.d/dyninst.conf && ldconfig && \
apt-get -y autoremove && \
rm -rf /var/lib/apt/lists/*

ENV DYNINSTAPI_RT_LIB /usr/local/lib/libdyninstAPI_RT.so

CMD ["/bin/bash"]
