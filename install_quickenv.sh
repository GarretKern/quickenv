#!/bin/bash
set -e

# Download dotfiles
cd ~
curl -O https://raw.githubusercontent.com/GarretKern/quickenv/main/.bash_profile
curl -O https://raw.githubusercontent.com/GarretKern/quickenv/main/.bashrc
curl -O https://raw.githubusercontent.com/GarretKern/quickenv/main/.tmux.conf
curl -O https://raw.githubusercontent.com/GarretKern/quickenv/main/init.vim
mkdir -p ~/.config/nvim
mv init.vim ~/.config/nvim/init.vim

# Install vim plugins
if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]; then
  echo "Installing vim plug and plugins"
  # install vim-plug, a package manager for neovim
  curl -Lo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# After nvim is installed run :PlugInstall to install plugins from dotfile
