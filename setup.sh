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
if isCmdExist git; then
  echo "please install git"
  exit
elif isCmdExist zsh; then
  echo "please install zsh"
  exit
fi

# 2. zsh
chsh -s $(which zsh)
exec $SHELL -l
# NOTE: still bash until reboot

# 3. vim
mkdir -p $HOME/.vim/colors
mkdir -p $HOME/.vim/backup
cp vim/solarized $HOME/.vim/colors/

# 4. TODO: python
# $CURRENT_DIR/scripts/install_python.sh

# 5. set paths
ln -sf $CURRENT_DIR/vim/vimrc $HOME/.vimrc
ln -sf $CURRENT_DIR/zsh/zshrc $HOME/.zshrc

# 6. github
git config --global user.email "xingchensong1996@163.com"
git config --global user.name "Xingchen Song"
