#!/bin/bash
# Simple setup.sh for configuring CentOS 7 instance
# for headless setup. 

cd $HOME

# update yum repo info 
sudo yum update -y

# install git
sudo yum install -y git

# Load node and npm from the EPEL repository
sudo yum install -y epel-release
sudo yum install -y nodejs npm --enablerepo=epel

# Install jshint to allow checking of JS code within emacs
# http://jshint.com/
npm install -g jshint

# Install rlwrap to provide libreadline features with node
# See: http://nodejs.org/api/repl.html#repl_repl
sudo yum install -y rlwrap

# Install emacs24
# https://launchpad.net/~cassou/+archive/emacs
sudo yum install -y emacs

# Install Heroku toolbelt, and ruby which it needs
# https://toolbelt.heroku.com/debian
sudo yum install -y ruby
wget -qO- https://toolbelt.heroku.com/install.sh | sh

# git pull and install dotfiles as well
cd $HOME
if [ -d ./dotfiles/ ]; then
    mv dotfiles dotfiles.old
fi
if [ -d .emacs.d/ ]; then
    mv .emacs.d .emacs.d~
fi
git clone https://github.com/jimbark/c7dotfiles.git
ln -sb dotfiles/.screenrc .
ln -sb dotfiles/.bash_profile .
ln -sb dotfiles/.bashrc .
ln -sb dotfiles/.bashrc_custom .
ln -sf dotfiles/.emacs.d .

