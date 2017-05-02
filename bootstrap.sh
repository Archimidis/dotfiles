#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE}")" && pwd)"
echo Creating symbolic links in $BASEDIR

# vim
echo Creating symbolic links for vim
ln -s ${BASEDIR}/vim/.vimrc ~/.vimrc
ln -s ${BASEDIR}/vim/.vim/ ~/.vim

# zsh
# echo Creating symbolic links for zsh
# ln -s ${BASEDIR}/zshrc ~/.zshrc

# git
# echo Creating symbolic links for git
# ln -s ${BASEDIR}/gitconfig ~/.gitconfig

# tmux
# echo Creating symbolic links for tmux 
# ln -s ${BASEDIR}/tmux.conf ~/.tmux.conf

# haskell
ln -s ${BASEDIR}/ghc/.ghci ~/ghci
