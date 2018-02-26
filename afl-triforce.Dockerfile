FROM fdiskyou/afl-qemu:0.1
MAINTAINER rui@deniable.org

# check https://hub.docker.com/u/fdiskyou/ for more information

ENV K kern

RUN apt-get update && apt-get -y upgrade && \
apt-get -y install linux-image-$(uname -r) && cd ~/WRKSRC && \
git clone https://github.com/nccgroup/TriforceAFL.git && \
cd TriforceAFL && make && \
git clone https://github.com/nccgroup/TriforceLinuxSyscallFuzzer.git && \
cd TriforceLinuxSyscallFuzzer && make && mkdir kern && \
cp /boot/vmlinuz* kern/bzImage && \
cp /boot/System.map* kern/kallsyms && \
make inputs && \
apt-get -y autoremove && \
rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
