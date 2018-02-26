FROM fdiskyou/afl-dyninst:0.1
MAINTAINER rui@deniable.org

# check https://hub.docker.com/u/fdiskyou/ for more information

RUN apt-get update && apt-get -y upgrade && \
apt-get -y build-dep qemu && \
apt-get -y install libtool-bin wget automake bison && \
cd ~/WRKSRC && cd afl-* && cd qemu_mode && \
./build_qemu_support.sh && cd .. && make install && \
apt-get -y autoremove && \
rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
