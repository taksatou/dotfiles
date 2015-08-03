#!/bin/bash

./reload-submodules.sh

OLD_DOTFILES=$HOME/.old_dotfiles.d
DOTFILES='.emacs.d .vimrc .emacs .tmux.conf .zshrc .pryrc .bashrc .my.cnf .sbclrc .gemrc .screenrc'

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

EMACS=/usr/bin/env which emacs
if [ ! -z $EMACS ]; then 
    if [ "f" = `$EMACS --version | head -n 1 | perl -ne 'print($1>23?f:"") if /(\d+)\.(\d+)\.(\d+)/;'` ]; then
        # init skk
        make -C $PWD/.emacs.d/ddskk-14.4
        make -C $PWD/.emacs.d/ddskk-15.1
        touch ~/.skk-jisyo

        # init package
        $EMACS --script setup.el
    fi
fi


## setup peco
TMPDIR=`mktemp -d`
wget https://github.com/peco/peco/releases/download/v0.2.3/peco_linux_amd64.tar.gz -O $TMPDIR/peco.tgz
tar xzf $TMPDIR/peco.tgz -C $TMPDIR
mkdir -p $HOME/bin
cp $TMPDIR/peco_linux_amd64/peco $HOME/bin
