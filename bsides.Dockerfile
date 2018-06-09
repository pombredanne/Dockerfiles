# Dockerfile for The Linux Heap Exploitation Workshop @ BSides 2018 
FROM ubuntu:14.04
MAINTAINER rui@deniable.org 

# If MALLOC_CHECK_ is set to 0 (zero), the memory management functions are simply most tolerant of errors and do not give warnings.
# https://www.novell.com/support/kb/doc.php?id=3113982
ENV MALLOC_CHECK_ 0
ENV WRKSRC /opt
ENV WRKDIR /root/labs
WORKDIR $WRKDIR
 
RUN mkdir -p $WRKDIR && apt-get update && apt-get upgrade -y && apt-get install -y sudo \
  git build-essential gdb wget curl vim gcc gcc-multilib g++-multilib eglibc-source && \
  cd /usr/src/glibc && tar xf eglibc-2.19.tar.xz && \
  cd $WRKSRC && git clone https://github.com/pwndbg/pwndbg && \
  cd pwndbg && ./setup.sh && cd $WRKSRC && \
  git clone https://github.com/Svenito/exploit-pattern && \
  git clone https://github.com/n30m1nd/Linux_Heap_Exploitation_Intro_Series && \
  echo "dir /usr/src/glibc/eglibc-2.19/malloc/" >> /root/.gdbinit
 
ENTRYPOINT ["/bin/bash"]
