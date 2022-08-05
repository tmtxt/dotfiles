#! /usr/bin/env sh

# INSTALLATION FILE FOR GITHUB CODESPACES

mkdir ~/projects
git clone https://github.com/tmtxt/dotfiles.git ~/projects/dotfiles

# remove default .zshrc file
mv ~/.zshrc ~/.zshrc-default
ln -s $HOME/projects/dotfiles/.zshrc ~/.zshrc
chsh -s $(which zsh)
