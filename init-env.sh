#!/bin/bash

./reload-submodules.sh

OLD_DOTFILES=$HOME/.old_dotfiles.d
DOTFILES='.emacs.d .vimrc .emacs .tmux.conf .zshrc .pryrc .bashrc .my.cnf .sbclrc'

PWD=`pwd`
BACKUP_DIR=$OLD_DOTFILES/`date +%s`
mkdir -p $BACKUP_DIR


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

which emacs > /dev/null
if [ $? = 0 -a "f" = `emacs --version | head -n 1 | perl -ne 'print($1>23?f:"") if /(\d+)\.(\d+)\.(\d+)/;'` ]; then
    # init skk
    make -C $PWD/.emacs.d/ddskk-14.4
    make -C $PWD/.emacs.d/ddskk-15.1
    touch ~/.skk-jisyo

    # init package
    emacs --script setup.el
fi
