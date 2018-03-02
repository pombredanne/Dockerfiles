FROM fdiskyou/afl-dyninst:0.1
MAINTAINER rui@deniable.org

# check https://hub.docker.com/u/fdiskyou/ for more information
ENV WRKSRC /opt
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y upgrade && \
apt-get -y build-dep qemu && \
apt-get -y install libtool-bin wget automake bison && \
cd $WRKSRC && cd afl-* && cd qemu_mode && \
./build_qemu_support.sh && cd .. && make install && \
apt-get -qy clean autoremove && \
rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
