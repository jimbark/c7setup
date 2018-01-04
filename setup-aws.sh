#!/bin/bash
# Simple setup.sh for configuring AWS Linux instance
# for headless setup. 

cd $HOME

# update yum repo info 
sudo yum update -y

# install git
sudo yum install -y git

# Install EPEL repository
sudo yum install -y epel-release

#Load node and npm from the EPEL repository
#sudo yum install -y nodejs npm --enablerepo=epel

# Load node and npm from up to date source as EPEL version VERY old
# latest scripts and install info obtained from:  https://github.com/nodesource/distributions#rpm
curl --silent --location https://rpm.nodesource.com/setup_6.x | sudo bash -
sudo yum install -y nodejs

# Install jshint to allow checking of JS code within emacs
# http://jshint.com/
sudo npm install -g jshint

# Install rlwrap to provide libreadline features with node
# See: http://nodejs.org/api/repl.html#repl_repl
# note this installs from EPEL repo
sudo yum install -y rlwrap --enablerepo=epel  

# Install emacs24
# https://launchpad.net/~cassou/+archive/emacs
sudo yum install -y emacs

# Install Heroku toolbelt, and ruby which it needs
# https://toolbelt.heroku.com/debian
# commented out as not using Heroku on AWS at present; also this is the Debain version?
#sudo yum install -y ruby
#sudo yum install -y wget
#wget -qO- https://toolbelt.heroku.com/install.sh | sh

# git pull and install dotfiles as well
cd $HOME
if [ -d ./c7dotfiles/ ]; then
    mv c7dotfiles c7dotfiles.old
fi
if [ -d .emacs.d/ ]; then
    mv .emacs.d .emacs.d~
fi
git clone https://github.com/jimbark/c7dotfiles.git
ln -sb c7dotfiles/.screenrc .
ln -sb c7dotfiles/.bash_profile .
ln -sb c7dotfiles/.bashrc .
ln -sb c7dotfiles/.bashrc_custom .
ln -sf c7dotfiles/.emacs.d .

# network debugging tools
sudo yum install -y tcpdump   
sudo yum install -y net-tools 

# various packages required to install and run linkchecker
sudo yum install -y python-devel 
sudo yum install -y gcc qt-devel
sudo yum install -y python-pip
sudo pip install LinkChecker
sudo pip install requests==2.9.2

# in order to run mocha at cli need it installed globally
sudo npm install -g mocha 
sudo npm install -g grunt-cli

# clone my applucation repo
git clone https://github.com/jimbark/memlist2.git 
cd ~/memlist2
npm install 

# create crontab entry to start my app automatically on reboot
#write out current crontab
crontab -l > mycron
#echo new cron into cron file
echo "@reboot /home/ec2-user/memlist2/after-reboot.sh" >> mycron
#install new cron file
crontab mycron
rm mycron






