#!/bin/bash

OLD_DOTFILES=$HOME/.old_dotfiles.d
DOTFILES='.emacs.d .vimrc .emacs .tmux.conf .zshrc'

PWD=`dirname $0`
BACKUP_DIR=$OLD_DOTFILES/`date +%s`
mkdir -p $BACKUP_DIR

make -C $PWD/.emacs.d/ddskk-14.4 clean

for i in $DOTFILES; do
    if [ ! -e $PWD/$i ]; then
	echo "$i doesn't exist"
	exit 1
    fi
done
    
for i in $DOTFILES; do
    if [ -e $HOME/$i -o -L $HOME/$i ]; then
	mv $HOME/$i $BACKUP_DIR/$i
    fi
    ln -s $PWD/$i $HOME/$i
done
