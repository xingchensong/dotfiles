#!/bin/bash
# Copyright [2021-09-22] <sxc19@mails.tsinghua.edu.cn, Xingchen Song>

CUDA_VERSION=11.3.1
OS_VERSION=20.04
TRT_VERSION=8.0.1.6

# TensorRT GA build, need login
# wget https://developer.nvidia.com/compute/machine-learning/tensorrt/secure/8.0.3/tars/tensorrt-8.0.3.4.linux.x86_64-gnu.cuda-10.2.cudnn8.2.tar.gz
export TRT_LIBPATH=`pwd`/TensorRT-8.0.1.6

# Install requried libraries
sudo apt-get update && sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update && sudo apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    wget \
    zlib1g-dev \
    git \
    pkg-config \
    sudo \
    ssh \
    libssl-dev \
    pbzip2 \
    pv \
    bzip2 \
    unzip \
    devscripts \
    lintian \
    fakeroot \
    dh-make \
    build-essential

# Install TensorRT
v="${TRT_VERSION%.*}-1+cuda${CUDA_VERSION%.*}" &&\
   sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub &&\
    sudo apt-get update &&\
    sudo apt-get install libnvinfer8=${v} libnvonnxparsers8=${v} libnvparsers8=${v} libnvinfer-plugin8=${v} \
        libnvinfer-dev=${v} libnvonnxparsers-dev=${v} libnvparsers-dev=${v} libnvinfer-plugin-dev=${v} \
        python3-libnvinfer=${v}

# Install PyPI packages
cd TensorRT
pip3 install --upgrade pip
pip3 install setuptools>=41.0.0
pip3 install -r requirements.txt
pip3 install jupyter jupyterlab
# Workaround to remove numpy installed with tensorflow
pip3 install --upgrade numpy
cd ..
