#! /bin/bash

sudo aptitude install -y vim bash-completion

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

${LN} -sT ${PWD}/git/dotgit ~/.git
${LN} -sT ${PWD}/git/.gitconfig ~/.gitconfig
${LN} -sT ${PWD}/.tmux.conf ~/.tmux.conf
${LN} -sT ${PWD}/.asciidoc ~/.asciidoc

${LN} -sT ${PWD}/zsh/zshrc ~/.zshrc
${LN} -sT ${PWD}/zsh/oh-my-zsh ~/.oh-my-zsh

${LN} -sT ${PWD}/.screenrc ~/.screenrc

#git submodule update --init
#git submodule sync

vim +'PlugInstall --sync' +qall
