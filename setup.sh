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
  echo "install zsh now"
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
  else
    echo "root user is not supported"
    exit
  fi
fi
export PATH=$HOME/.local/bin:/usr/bin:$PATH
export LD_LIBRARY_PATH=$HOME/.local/lib:/usr/lib:$LD_LIBRARY_PATH
./zsh/fonts/install.sh
# chsh -s $HOME/.local/bin/zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "install oh-my-zsh via zsh/install_oh_my_zsh_079e7bb5e0a79171f3356d55d3f6302a82645a39.sh"
  sh zsh/install_oh_my_zsh_079e7bb5e0a79171f3356d55d3f6302a82645a39.sh --unattended --keep-zshrc
fi
cp -R zsh/zsh-autosuggestions  $HOME/.oh-my-zsh/custom/plugins/
cp -R zsh/zsh-syntax-highlighting  $HOME/.oh-my-zsh/custom/plugins/

# 2. vim && vim-plug, tmux && tmux-plug
mkdir -p $HOME/.vim/colors
mkdir -p $HOME/.vim/backup
cp vim/color/*.vim $HOME/.vim/colors/
mkdir -p $HOME/.vim/autoload
cp $CURRENT_DIR/vim/vim-plug/plug.vim $HOME/.vim/autoload
mkdir -p $HOME/.tmux
mkdir -p $HOME/.tmux/plugins
if [ ! -e "$HOME/.tmux/plugins/tpm" ]; then
  ln -s $CURRENT_DIR/tmux/tpm $HOME/.tmux/plugins/tpm
else
  echo "tmp exists: $HOME/.tmux/plugins/tpm"
fi

# 3. python3-pip clang ctags
# see scripts/install_pkg.sh

# 4. set paths
if [[ -e "$HOME/.vimrc" && ! -L "$HOME/.vimrc"  ]]; then
  echo "'$HOME/.vimrc' 存在且不是符号链接。正在创建备份..."
  cp -p $HOME/.vimrc $HOME/.vimrc.bak
  ln -sf $CURRENT_DIR/vim/vimrc $HOME/.vimrc
else
  echo "'$HOME/.vimrc' 不存在或者是符号链接。正在生成..."
  ln -sf $CURRENT_DIR/vim/vimrc $HOME/.vimrc
fi

if [[ -e "$HOME/.zshrc" && ! -L "$HOME/.zshrc"  ]]; then
  echo "'$HOME/.zshrc' 存在且不是符号链接。正在创建备份..."
  cp -p $HOME/.zshrc $HOME/.zshrc.bak
  ln -sf $CURRENT_DIR/zsh/zshrc $HOME/.zshrc
else
  echo "'$HOME/.zshrc' 不存在或者是符号链接。正在生成..."
  ln -sf $CURRENT_DIR/zsh/zshrc $HOME/.zshrc
fi

if [[ -e "$HOME/.bashrc" && ! -L "$HOME/.bashrc"  ]]; then
  echo "'$HOME/.bashrc' 存在且不是符号链接。正在创建备份..."
  cp -p $HOME/.bashrc $HOME/.bashrc.bak
  ln -sf $CURRENT_DIR/bash/bashrc $HOME/.bashrc
else
  echo "'$HOME/.bashrc' 不存在或者是符号链接。正在生成..."
  ln -sf $CURRENT_DIR/bash/bashrc $HOME/.bashrc
fi

if [[ -e "$HOME/.bash_profile" && ! -L "$HOME/.bash_profile"  ]]; then
  echo "'$HOME/.bash_profile' 存在且不是符号链接。正在创建备份..."
  cp -p $HOME/.bash_profile $HOME/.bash_profile.bak
  ln -sf $CURRENT_DIR/bash/bashrc $HOME/.bash_profile
else
  echo "'$HOME/.bash_profile' 不存在或者是符号链接。正在生成..."
  ln -sf $CURRENT_DIR/bash/bashrc $HOME/.bash_profile
fi

if [[ -e "$HOME/.profile" && ! -L "$HOME/.profile"  ]]; then
  echo "'$HOME/.profile' 存在且不是符号链接。正在创建备份..."
  cp -p $HOME/.profile $HOME/.profile.bak
  ln -sf $CURRENT_DIR/bash/bashrc $HOME/.profile
else
  echo "'$HOME/.profile' 不存在或者是符号链接。正在生成..."
  ln -sf $CURRENT_DIR/bash/bashrc $HOME/.profile
fi


if [[ -e "$HOME/.tmux.conf" && ! -L "$HOME/.tmux.conf"  ]]; then
  echo "'$HOME/.tmux.conf' 存在且不是符号链接。正在创建备份..."
  cp -p $HOME/.tmux.conf $HOME/.tmux.conf.bak
  ln -sf $CURRENT_DIR/tmux/tmux.conf $HOME/.tmux.conf
else
  echo "'$HOME/.tmux.conf' 不存在或者是符号链接。正在生成..."
  ln -sf $CURRENT_DIR/tmux/tmux.conf $HOME/.tmux.conf
fi

if [[ -e "$HOME/.gitconfig" && ! -L "$HOME/.gitconfig"  ]]; then
  echo "'$HOME/.gitconfig' 存在且不是符号链接。正在创建备份..."
  cp -p $HOME/.gitconfig $HOME/.gitconfig.bak
  ln -sf $CURRENT_DIR/git/gitconfig $HOME/.gitconfig
else
  echo "'$HOME/.gitconfig' 不存在或者是符号链接。正在生成..."
  ln -sf $CURRENT_DIR/git/gitconfig $HOME/.gitconfig
fi

if [[ -e "$HOME/.oh-my-zsh/themes/avit.zsh-theme" && ! -L "$HOME/.oh-my-zsh/themes/avit.zsh-theme"  ]]; then
  echo "'$HOME/.oh-my-zsh/themes/avit.zsh-theme' 存在且不是符号链接。正在创建备份..."
  cp -p $HOME/.oh-my-zsh/themes/avit.zsh-theme $HOME/.oh-my-zsh/themes/avit.zsh-theme.bak
  ln -sf $CURRENT_DIR/zsh/avit.zsh-theme $HOME/.oh-my-zsh/themes/avit.zsh-theme
else
  echo "'$HOME/.oh-my-zsh/themes/avit.zsh-theme' 不存在或者是符号链接。正在生成..."
  ln -sf $CURRENT_DIR/zsh/avit.zsh-theme $HOME/.oh-my-zsh/themes/avit.zsh-theme
fi

if [ ! -e "$HOME/.vim/UltiSnips" ]; then
  echo "'$HOME/.vim/UltiSnips' 不存在。正在生成..."
  ln -s $PWD/vim/snippets $HOME/.vim/UltiSnips
else
  echo "'$HOME/.vim/UltiSnips' 存在。跳过"
fi

vim +'PlugInstall --sync' +qa
sed -i 's/command! -nargs=0 -complete=customlist,NERDTreeCompleteProjectNames NERDTreeProjectLoadFromCWD call g:NERDTreeProject.LoadFromCWD()/command! -nargs=* -complete=customlist,NERDTreeCompleteProjectNames NERDTreeProjectLoadFromCWD call g:NERDTreeProject.LoadFromCWD()/' $HOME/.vim/vim_plug/nerdtree-project-plugin/nerdtree_plugin/project.vim
tmux source $HOME/.tmux.conf
$HOME/.tmux/plugins/tpm/bin/install_plugins

echo "DONE"
