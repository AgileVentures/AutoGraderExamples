#!/bin/bash
# Simple autograder setup.sh run by Vagrant

##########################################


######  PERSONALIZE  #######
#
REPO=AgileVentures/AutoGraderExamples.git

CLONE_AS=AutoGraderExamples
BRANCH=develop

# THESE ENV VARS MUST BE SET SO NOT VISIBLE HERE
#
USER=$GH_USER
PASS=$GH_PASS

# Chowns all the files
LINUX_USER_GROUP=vagrant:admin


############################


sudo apt-get install -y git
sudo apt-get install -y curl

\curl -L https://get.rvm.io | bash -s stable  --ruby=1.9.3-p484

## doesn't seem needed, current default is 2.2.2
gem update --system 2.2.0

#rvm command output says to do this.
sudo usermod -a -G rvm vagrant
groups

#rvm command output says to do this too.
source /etc/profile.d/rvm.sh

rvm requirements
rvm reload


#GIT_PATH=github.com/$REPO
#git clone https://$USER:$PASS@$GIT_PATH $CLONE_AS
#cd $CLONE_AS
#git checkout $BRANCH


#cd ..
sudo chown -R $LINUX_USER_GROUP .
#cd $CLONE_AS


#cd /vagrant

## This works per travis file
gem install cucumber
gem install rspec
#cucumber install
#cucumber features


## This works too
# bundle install
# bundle exec cucumber install
## both the bundle processes seem to run at once..
## likely it flubbed, go and do rag bundle install in a separate step:
# cd rag
# bundle install
# cd ..
# cucumber features
