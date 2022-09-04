#! /bin/bash

sudo apt-get install -y --no-install-recommends git-crypt neovim python3-neovim bash-completion

if [ `uname` == 'Darwin' ] ; then
	LN=gln
	MKDIR=gmkdir
	RMDIR=grmdir
	CP=gcp
else
	LN=ln
	MKDIR=mkdir
	RMDIR=rmdir
	CP=cp
fi

PWD=`pwd`

if [ -d /etc/skel/ ] ; then
	for i in /etc/skel/.* ; do
		[ `basename $i` != .. ] && [ `basename $i` != . ] && ${LN} -s $i ~/
	done
fi

${MKDIR} -p ~/.ssh
${LN} -sT ${PWD}/ssh/authorized_keys ~/.ssh/authorized_keys
${LN} -sT ${PWD}/ssh/config ~/.ssh/config
${LN} -sT ${PWD}/ssh/config.d ~/.ssh/config.d

${LN} -sT ${PWD}/vim/.vimrc ~/.vimrc
${LN} -sT ${PWD}/vim/.vim ~/.vim

${MKDIR} -p ~/.config/nvim
${LN} -sT ${PWD}/nvim ~/.config/nvim/init.vim

${LN} -sT ${PWD}/git/dotgit ~/.git
${LN} -sT ${PWD}/git/.gitconfig ~/.gitconfig
${LN} -sT ${PWD}/.tmux.conf ~/.tmux.conf
${LN} -sT ${PWD}/.asciidoc ~/.asciidoc

if [ "$SHELL" = "/usr/bin/zsh" ] ; then
    ${LN} -sT ${PWD}/zsh/zshrc ~/.zshrc
fi

${LN} -sT ${PWD}/.screenrc ~/.screenrc

vim +'PlugInstall --sync' +qall
