#! /bin/bash

sudo apt-get install -y --no-install-recommends neovim python3-neovim bash-completion

if [ `uname` == 'Darwin' ] ; then
	LN=gln
	MKDIR=gmkdir
	CP=gcp
else
	LN=ln
	MKDIR=mkdir
	CP=cp
fi

PWD=`pwd`

if [ -d /etc/skel/ ] ; then
	for i in /etc/skel/.* ; do
		[ `basename $i` != .. ] && [ `basename $i` != . ] && ${LN} -s $i ~/
	done
fi

${MKDIR} -p ~/.ssh/conf.d

${LN} -sT ${PWD}/ssh/authorized_keys ~/.ssh/authorized_keys
${LN} -sT ${PWD}/ssh/config ~/.ssh/config

${LN} -sT ${PWD}/vim/.vimrc ~/.vimrc
${LN} -sT ${PWD}/vim/.vim ~/.vim

${MKDIR} -p ~/.config/nvim
${LN} -sT ${PWD}/nvim ~/.config/nvim/init.vim

${LN} -sT ${PWD}/git/dotgit ~/.git
${LN} -sT ${PWD}/git/.gitconfig ~/.gitconfig
${LN} -sT ${PWD}/.tmux.conf ~/.tmux.conf
${LN} -sT ${PWD}/.asciidoc ~/.asciidoc

${LN} -sT ${PWD}/zsh/zshrc ~/.zshrc

if [ "$SHELL" = "/usr/bin/zsh" ] ; then
    if [ ! -d "~/.oh-my-zsh/" ] ; then
        git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    fi
fi

${LN} -sT ${PWD}/.screenrc ~/.screenrc

vim +'PlugInstall --sync' +qall
