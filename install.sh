#! /usr/bin/env sh

# INSTALLATION FILE FOR GITHUB CODESPACES

mkdir ~/projects
git clone https://github.com/tmtxt/dotfiles.git ~/projects/dotfiles

# git editor
git config --global core.editor "code --wait"

# remove default .zshrc file
mv ~/.zshrc ~/.zshrc-default
ln -s $HOME/projects/dotfiles/.zshrc ~/.zshrc
sudo chsh -s $(which zsh) $USER
