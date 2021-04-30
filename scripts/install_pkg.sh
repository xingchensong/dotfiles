#!/bin/bash
# Xingchen Song @ 2020-12-30

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install python3-pip clang ctags zsh

# set priority
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 3
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.5 1
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.7 3
sudo update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1

sudo update-alternatives --install /usr/bin/pip3 pip3 /usr/bin/pip3.7 3
sudo update-alternatives --install /usr/bin/pip3 pip3 /usr/bin/pip3.5 1
sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip3.7 3
sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip2.7 1

# update vim (>= 8.2)

pip3 install --user pynvim neovim jedi autopep8
