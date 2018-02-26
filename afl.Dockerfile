FROM phusion/baseimage:0.10.0
MAINTAINER rui@deniable.org

# set the following in your host to propagate to the container
# echo core > /proc/sys/kernel/core_pattern
# echo performance | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

RUN apt-get update && apt-get -y upgrade && \
apt-get -y install curl build-essential llvm-4.0 clang-4.0 && \ 
update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-4.0 100 && \
update-alternatives --install /usr/bin/clang clang /usr/bin/clang-4.0 100 && \
ln -s /usr/bin/llvm-config-4.0 /usr/bin/llvm-config && \
mkdir -p ~/WRKSRC && mkdir -p ~/TARGETS && mkdir -p ~/WRKDIR && cd ~/WRKSRC && \
curl -L http://lcamtuf.coredump.cx/afl/releases/afl-latest.tgz | tar zxf - && \
cd afl-* && make && cd llvm_mode && make && cd .. && make install && \
apt-get -y autoremove && \
rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
