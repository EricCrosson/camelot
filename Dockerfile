FROM admiringworm/ubuntu
MAINTAINER Eric Crosson (eric.s.crosson@utexas.edu)

ENTRYPOINT [ "/bin/bash" ]

RUN apt-get update -qq && apt-get install -qq -y \
    git \
    bison \
    make \
    wget \
    g++

RUN wget http://spinroot.com/spin/Src/src645.tar.gz
RUN tar xf *.tar.gz
RUN make -C Src6.4.5 && make -C Src6.4.5 install
