#!/bin/bash

DOTFILES=(.tmux.conf .vimrc .zshrc)

for file in ${DOTFILES[@]}
do
    ln -fnsv $HOME/.dotfiles/$file $HOME/$file
done

mkdir -p ~/.config/nvim
ln -fnsv $HOME/.dotfiles/.vimrc $HOME/.config/nvim/init.vim

if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone git@github.com:tmux-plugins/tpm.git ~/.tmux/plugins/tpm
fi

if [ ! -d ~/.zplug ]; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > dein_installer.sh
sh ./dein_installer.sh $HOME/.vim/dein
rm dein_installer.sh
