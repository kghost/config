#! /bin/bash

sudo apt-get install -y --no-install-recommends git-crypt bash-completion dbus-user-session

if [ `uname` == 'Darwin' ] ; then
	LN=gln
	MKDIR=gmkdir
	RMDIR=grmdir
	CP=gcp
	RM=grm
else
	LN=ln
	MKDIR=mkdir
	RMDIR=rmdir
	CP=cp
	RM=rm
fi

PWD=`pwd`

if [ -d /etc/skel/ ] ; then
	for i in /etc/skel/.* ; do
		[ `basename $i` != .. ] && [ `basename $i` != . ] && ${LN} -s $i ~/
	done
fi

${MKDIR} -p ~/.ssh
${MKDIR} -p ~/.ssh/masters
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

if [ "$SHELL" = "/bin/zsh" -o "$SHELL" = "/usr/bin/zsh" ] ; then
    ${LN} -sT ${PWD}/zsh/zshrc ~/.zshrc
fi

${LN} -sT ${PWD}/.screenrc ~/.screenrc

${MKDIR} -p ~/.gnupg
if [ ! -L ~/.gnupg/gpg.conf ] ; then
    ${RM} ~/.gnupg/gpg.conf
fi
${LN} -sT ${PWD}/gpg/gpg.conf ~/.gnupg/gpg.conf

vim +'PlugInstall --sync' +qall

if [ "$(id -u)" != "1000" ] ; then
    echo "$(tput bold)Warning$(tput sgr0): Your uid is not 1000"
fi
