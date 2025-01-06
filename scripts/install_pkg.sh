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

# install miniconda3-py3.x
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
# update vim (>= 9.0.1425) nodejs (>= 16.13.1) for copilot, tmux (>= 3.3) for xx (?), cmake (>=3.10.1) for c++ projects
# # https://anaconda.org/conda-forge/vim
# # https://anaconda.org/conda-forge/cmake
# # https://anaconda.org/conda-forge/tmux
# # https://anaconda.org/conda-forge/nodejs
conda update -n base conda -y && conda install -y pip
conda install -c conda-forge git vim zsh shellcheck tmux cmake nodejs ruby gawk ctags -y
conda install -c conda-forge gcc=11.4.0 gxx=11.4.0 libstdcxx-devel_linux-64=11.4.0 ld_impl_linux-64 sysroot_linux-64=2.17 -y
# conda search cudatoolkit
# conda install cudatoolkit
pip install pynvim neovim jedi autopep8 cpplint pylint isort cmakelint cmake-format flake8 gpustat nvitop -i https://pypi.tuna.tsinghua.edu.cn/simple
pip install torch==2.5.1+cu121 torchaudio==2.5.1+cu121 --extra-index-url https://download.pytorch.org/whl/cu121
# autojump
git clone https://github.com/wting/autojump.git
cd autojump && ./install.py
