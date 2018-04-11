FROM ubuntu:xenial
MAINTAINER rui@deniable.org

# prerequisites
RUN apt-get update && apt-get install -y --no-install-recommends wget git python-pip && \
# add sources
sh -c 'echo "deb http://llvm.org/apt/xenial/ llvm-toolchain-xenial-4.0 main" >> /etc/apt/sources.list.d/llvm.list' && \
sh -c 'echo "deb-src http://llvm.org/apt/xenial/ llvm-toolchain-xenial-4.0 main" >> /etc/apt/sources.list.d/llvm.list' && \
wget -O - http://llvm.org/apt/llvm-snapshot.gpg.key | apt-key add - && \
apt-get update && apt-get install -y gcc-4.8 g++-4.8 cmake clang-3.4 llvm-4.0-tools  libcap-dev zlib1g-dev bison flex ncurses-dev && \
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 20 && \
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 20 && \
update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.4 20 && \
update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.4 20 && \
pip install tabulate && \
# STP
cd /opt && mkdir stp && cd stp && \
git clone https://github.com/stp/minisat && \
cd minisat && mkdir build && cd build && MINISAT_DIR=`pwd` && \
cmake -DCMAKE_INSTALL_PREFIX=/usr .. && make && make install && \
cd ../../ && \
git clone --depth 1 https://github.com/stp/stp.git src && \
mkdir build && cd build && \
cmake -DBUILD_SHARED_LIBS:BOOL=OFF -DENABLE_PYTHON_INTERFACE:BOOL=OFF -DNO_BOOST:BOOL=ON ../src && \
make && \
# uclibc
cd /opt && \
git clone --depth 1 https://github.com/klee/klee-uclibc.git && \
cd klee-uclibc && \
./configure --make-llvm-lib --with-cc /usr/bin/clang-3.4 --with-llvm-config /usr/bin/llvm-config-4.0 && \
make && \
# klee
cd /opt && \
git clone --depth 1 https://github.com/klee/klee.git && \
cd klee && \
./configure --with-llvmsrc=/usr/lib/llvm-4.0/build --with-llvmobj=/usr/lib/llvm-4.0/build --with-llvmcc=/usr/bin/clang-3.4 \
  --with-llvmcxx=/usr/bin/clang++-3.4 --with-stp=/opt/stp/build --with-uclibc=/opt/klee-uclibc && \
make DISABLE_ASSERTIONS=1 ENABLE_OPTIMIZED=1 ENABLE_SHARED=0 install && \
# bob user
adduser bob --disabled-password --gecos "" && \
echo "ALL            ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers && \
mkdir /home/bob/WRKDIR && \
chown -R bob:bob /home/bob /home/bob/WRKDIR && \
# cleanup
apt-get remove --purge -y wget git cmake bison flex python-pip && \
apt-get autoclean && apt-get clean && \
rm -rf /var/lib/apt/lists/* /var/tmp/*

USER bob
ENV HOME=/home/bob

VOLUME ["/home/bob/WRKDIR"]
WORKDIR /home/bob/WRKDIR

CMD ["/bin/bash"]
