#!/bin/bash
# Xingchen Song @ 2020-12-30

# sudo apt-get update
# sudo apt-get upgrade
# sudo apt-get install python3-pip clang ctags zsh
# # set priority
# sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 3
# sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.5 1
# sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.7 3
# sudo update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1
#
# sudo update-alternatives --install /usr/bin/pip3 pip3 /usr/bin/pip3.7 3
# sudo update-alternatives --install /usr/bin/pip3 pip3 /usr/bin/pip3.5 1
# sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip3.7 3
# sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip2.7 1

# install miniconda3-py3.8
wget https://repo.anaconda.com/miniconda/Miniconda3-py38_4.10.3-Linux-x86_64.sh
# update vim (>= 9.0.1425) nodejs (>= 16.13.1) for copilot, tmux (>= 3.3) for xx (?), cmake (>=3.10.1) for c++ projects
conda update -n base conda -y && conda install -y pip
conda install -c conda-forge vim=9.0.1425 zsh shellcheck tmux=3.3 cmake=3.22.1 nodejs=16.13.1 ruby gawk -y
pip3 install pynvim neovim jedi autopep8 cpplint pylint isort cmakelint cmake-format flake8 -i https://pypi.tuna.tsinghua.edu.cn/simple
# autojump
git clone git://github.com/wting/autojump.git
cd autojump && ./install.py
