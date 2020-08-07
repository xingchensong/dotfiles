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

# 1. pacman(archlinux) or apt(ubuntu) or yum(centos)
if isCmdExist pacman; then
  echo "systerm: archlinux"
  $CURRENT_DIR/scripts/install_pacman.sh
elif isCmdExist yum; then
  echo "systerm: centos"
  $CURRENT_DIR/scripts/install_yum.sh
elif isCmdExist apt-get; then
  echo "systerm: ubuntu"
  $CURRENT_DIR/scripts/install_apt.sh
fi

# 2. zsh
chsh -s $(which zsh)
exec $SHELL -l
# NOTE: still bash until reboot

# 3. vim
mkdir -p $HOME/.vim/colors
mkdir -p $HOME/.vim/backup
git clone https://github.com/altercation/vim-colors-solarized
mv ./vim-colors-solarized/colors/solarized.vim $HOME/.vim/colors/
rm -rf ./vim-colors-solarized

# 4. python
$CURRENT_DIR/scripts/install_python.sh

# 5. set paths
ln -sf $CURRENT_DIR/.vimrc $HOME/.vimrc
ln -sf $CURRENT_DIR/.zshenv $HOME/.zshenv
ln -sf $CURRENT_DIR/.zsh $HOME/.zsh
ln -sf $CURRENT_DIR/.tmux.conf $HOME/.tmux.conf
