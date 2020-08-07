#!/bin/bash

sudo apt-get update
sudo apt-get -y upgrade

# sudo apt-get install ***
sudo apt-get install zsh
sudo apt-get install git
sudo apt-get install tmux
sudo apt-get install --assume-yes xclip
sudo apt install xsel

# for CUDA
sudo apt-get install -y build-essential cmake git unzip pkg-config
sudo apt-get install -y libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev
sudo apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get install -y libxvidcore-dev libx264-dev
sudo apt-get install -y libgtk-3-dev
sudo apt-get install -y libhdf5-serial-dev graphviz
sudo apt-get install -y libopenblas-dev libatlas-base-dev gfortran
sudo apt-get install -y python-tk python3-tk python-imaging-tk

sudo apt-get install -y python2.7-dev python3-dev

sudo apt-get install -y linux-image-generic linux-image-extra-virtual
sudo apt-get install -y linux-source linux-headers-generic
