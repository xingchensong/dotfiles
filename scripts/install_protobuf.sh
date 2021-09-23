#!/bin/bash
# Copyright [2021-09-20] <sxc19@mails.tsinghua.edu.cn, Xingchen Song>

sudo apt-get install autoconf automake libtool curl make g++ unzip
git clone https://github.com/google/protobuf.git
cd protobuf
git submodule update --init --recursive
mkdir build
./autogen.sh
./configure --enable-shared --enable-static --prefix="$HOME/tools/local"
make -j4
make install
