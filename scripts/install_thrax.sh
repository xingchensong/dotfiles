#!/bin/bash
# Copyright [2021-09-02] <sxc19@mails.tsinghua.edu.cn, Xingchen Song>

# install openfst 1.6.7
wget https://github.com/mjansche/openfst/archive/1.6.7.zip
unzip 1.6.7.zip && cd openfst-1.6.7 &&
./configure --prefix="$HOME/tools/local" --enable-compact-fsts=yes --enable-compress=yes --enable-const-fsts=yes --enable-far=yes --enable-grm=yes --enable-linear-fsts=yes --enable-lookahead-fsts=yes --enable-mpdt=yes --enable-ngram-fsts=yes --enable-pdt=yes
make -j4
make install

# install thrax 1.2.9
wget http://www.openfst.org/twiki/pub/GRM/ThraxDownload/thrax-1.2.9.tar.gz
tar -xzf thrax-1.2.9.tar.gz && cd thrax-1.2.9 &&
./configure --prefix="$HOME/tools/local" "LDFLAGS=-L$HOME/tools/local/lib" "CXXFLAGS=-I$HOME/tools/local/include" LIBS=-lpthread
make -j4
make install
