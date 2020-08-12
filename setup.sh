#!/bin/bash

CURRENT_DIR=$(pwd)

# is a command exists? call like isCmdExist vim
function isCmdExist() {
	local cmd="$1"
	if [ -z "$cmd" ]; then
		echo "Usage isCmdExist yourCmd"
		return 1
	fi
	which "$cmd" >/dev/null 2>&1
	if [ $? -eq 0 ]; then
		return 0
	fi
	return 2
}

# 1. git and zsh
if ! isCmdExist git; then
  echo "please install git"
  exit
fi
if ! isCmdExist zsh; then
  echo "please install zsh"
  exit
else
  if [ `whoami` != "root" ]; then
    # install zsh for non-root user (enable change theme)
    mkdir -p $HOME/.local
    cd zsh
    tar xvJf zsh-5.8.tar.xz
    cd zsh-5.8
    ./configure --prefix="$HOME/.local"
    make
    make install
    cd ..
    rm -rf zsh-5.8
    cd ..
  fi
  export PATH=$HOME/.local/bin:/usr/bin:$PATH
  export LD_LIBRARY_PATH=$HOME/.local/lib:/usr/lib:$LD_LIBRARY_PATH
  ./zsh/fonts/install.sh
  # chsh -s $HOME/.local/bin/zsh
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "install oh-my-zsh via zsh/install_oh_my_zsh_079e7bb5e0a79171f3356d55d3f6302a82645a39.sh"
    sh zsh/install_oh_my_zsh_079e7bb5e0a79171f3356d55d3f6302a82645a39.sh
  fi
  cp -R zsh/zsh-autosuggestions  $HOME/.oh-my-zsh/custom/plugins/
  cp -R zsh/zsh-syntax-highlighting  $HOME/.oh-my-zsh/custom/plugins/
fi

# 2. vim && vim-plug
mkdir -p $HOME/.vim/colors
mkdir -p $HOME/.vim/backup
cp vim/color/*.vim $HOME/.vim/colors/
if [ ! -f "$HOME/.viminfo" ]; then
  rm $HOME/.viminfo
fi
mkdir -p $HOME/.vim/autoload
cp $CURRENT_DIR/vim/vim-plug/plug.vim $HOME/.vim/autoload

# 3. TODO: python
# $CURRENT_DIR/scripts/install_python.sh

# 4. set paths
ln -sf $CURRENT_DIR/vim/vimrc $HOME/.vimrc
ln -sf $CURRENT_DIR/zsh/zshrc $HOME/.zshrc
ln -sf $CURRENT_DIR/git/gitconfig $HOME/.gitconfig

# 5. github
git config --global user.email "xingchensong1996@163.com"
git config --global user.name "xingchensong"

# 6. launch zsh
echo "DONE"
echo "export PATH=$HOME/.local/bin:/usr/bin:$PATH" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=$HOME/.local/lib:/usr/lib:$LD_LIBRARY_PATH" >> ~/.bashrc
echo "zsh" >> ~/.bashrc
