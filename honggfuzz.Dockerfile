FROM phusion/baseimage:0.10.0
MAINTAINER rui@deniable.org

LABEL description="Base image for honggfuzz"

WORKDIR /WRKDIR

ENV TARGETS /TARGETS
ENV CORPUS /WRKDIR/corpus
ENV WRKSRC /opt
ENV DEBIAN_FRONTEND noninteractive

SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get -y upgrade && \
apt-get -y install python build-essential git cmake llvm-4.0 clang-4.0 && \
apt-get -y install binutils-dev libunwind-dev libunwind8 && \
cd $WRKSRC && git clone https://github.com/01org/processor-trace && \
cd processor-trace/ && mkdir build && cd build && \
cmake -G "Unix Makefiles" .. && make && make install && \
mkdir -p $TARGETS && mkdir -p $CORPUS && cd $WRKSRC && \
apt-get install libbfd-dev libunwind-dev && \
git clone https://github.com/google/honggfuzz && \
cd honggfuzz && make -j4 && make install && \
apt-get -qy clean autoremove && \
rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]

