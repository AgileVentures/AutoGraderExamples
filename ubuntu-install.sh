#!/bin/bash
# Simple autograder setup.sh run by Vagrant


sudo apt-get install -y git
sudo apt-get install -y curl

\curl -L https://get.rvm.io | bash -s stable  --ruby=1.9.3-p484

## doesn't seem needed, current default is 2.2.2
#gem update --system 2.2.0

#rvm command output says to do this.
sudo usermod -a -G rvm vagrant
groups

#rvm command output says to do this too.
source /etc/profile.d/rvm.sh

# these may not be needed
rvm requirements
rvm reload

sudo chown -R vagrant:admin .


## This works per travis file
gem install cucumber
gem install rspec

# vagrant ssh and do these after install
#cucumber install
#cucumber features

