#!/bin/bash
# Copyright [2021-09-07] <sxc19@mails.tsinghua.edu.cn, Xingchen Song>
#######################################################################################################
# # Dockerfile from nvidia
# # set base image (host OS)
# FROM conda/miniconda3

# # set the working directory in the container
# WORKDIR /workspace

# # install dependencies
# RUN conda update -n base -c defaults conda -y
# RUN conda install conda-build -y
# RUN apt-get update &&     apt-get install -y --reinstall build-essential &&     apt-get upgrade -y &&     apt-get install -y git &&     apt-get install make
# RUN git clone https://github.com/google/re2
# RUN cd re2 && make && make install
# RUN apt-get install build-essential -y && apt-get install wget -y
# RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v2.5.0/protobuf-2.5.0.tar.gz
# RUN tar xzvf protobuf-2.5.0.tar.gz
# RUN cd protobuf-2.5.0 && ./configure && make && make install && ldconfig
# RUN conda install -c conda-forge thrax=1.3.4 -y
# RUN git clone https://github.com/yzhang123/sparrowhawk.git
# RUN cd sparrowhawk &&  git checkout test &&   apt-get install -y autoconf &&     bash autoreconf && ./configure && make && make install && ldconfig
# RUN git clone https://github.com/kward/shunit2.git
# RUN echo "DONE"
#######################################################################################################

bash autoreconf

# ./configure "LDFLAGS=$LDFLAGS -L/home/xcsong/tools/openfst-1.6.7/src/lib -L/home/xcsong/tools/openfst-1.6.7/src/extensions/far -L/home/xcsong/tools/thrax-1.2.9/src/lib" "CXXFLAGS=$CXXFLAGS -I/home/xcsong/tools/openfst-1.6.7/src/include -I/home/xcsong/tools/thrax-1.2.9/src/include -I/home/xcsong/tools/re2 -I/home/xcsong/tools/protobuf-2.5.0/src/" "PATH=$PATH:/home/xcsong/tools/protobuf-2.5.0/src" LIBS=-lpthread
./configure --prefix="$HOME/tools/local" "LDFLAGS=$LDFLAGS -L$HOME/tools/local/lib" "CXXFLAGS=$CXXFLAGS -I$HOME/tools/local/include -I/home/xcsong/tools/re2" "PATH=$PATH:/home/xcsong/tools/protobuf-2.5.0/src" LIBS=-lpthread

# make -j6 "LDFLAGS=$LDFLAGS -L/home/xcsong/tools/openfst-1.6.7/src/lib -L/home/xcsong/tools/openfst-1.6.7/src/extensions/far -L/home/xcsong/tools/thrax-1.2.9/src/lib -L/home/xcsong/tools/protobuf-2.5.0/src -L/home/xcsong/tools/re2/obj" "CXXFLAGS=$CXXFLAGS -I/home/xcsong/tools/openfst-1.6.7/src/include -I/home/xcsong/tools/thrax-1.2.9/src/include -I/home/xcsong/tools/re2 -I/home/xcsong/tools/protobuf-2.5.0/src/" "PATH=$PATH:/home/xcsong/tools/protobuf-2.5.0/src"
make -j6 "LDFLAGS=$LDFLAGS -L$HOME/tools/local/lib -L/home/xcsong/tools/re2/obj" "CXXFLAGS=$CXXFLAGS -I$HOME/tools/local/include -I/home/xcsong/tools/re2" "PATH=$PATH:/home/xcsong/tools/protobuf-2.5.0/src"
