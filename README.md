[![Build Status](https://travis-ci.org/AgileVentures/AutoGraderExamples.png)](https://travis-ci.org/AgileVentures/AutoGraderExamples)

AutoGraderExamples
==================

Example Assignments for Use with the Ruby AutoGrader

**Usual platform:** linux or mac, ruby 1.9.3

## 2 types of install: Install on Class VM image **OR** Vagrant

### **Install on class VM from http://beta.saasbook.info/bookware-vm-instructions:**
- Fork on github: https://github.com/AgileVentures/AutoGraderExamples
- `git clone https://github.com/<your user name>/AutoGraderExamples`, and cd there.
- `ruby -v` should be '1.9.3'
- `git checkout develop` which is the default presently.
- `gem install cucumber rspec`
- `cucumber install`
- `cucumber features`
- **"Error due to Missing Gems?"** cd to AutoGraderExamples/rag/ and do `bundle install` there, then `cd ..`


### **Vagrant install:**
- install VirtualBox from https://www.virtualbox.org/wiki/Downloads
- install Vagrant from http://www.vagrantup.com/
- fork on github: https://github.com/AgileVentures/AutoGraderExamples
- install Git on your machine
  - on Windows add "C:\Program Files (x86)\Git\bin" (or the correct path on your machine) to your Path environment variable
- *ON YOUR HOST*: clone your repo
- cd to the cloned directory
- edit that Vagrantfile if you want the vm to use other than 1024 Mb memory and 1 cpu
- `vagrant box add hashicorp/precise32` => new-style image if you have new Vagrant.
  - on older versions of Vagrant: `vagrant box add precise32` and remove the same bit from Vagrantfile.
- `vagrant up`       => launches and provisions vm if first run, may see warnings and encoding error
- `vagrant ssh`      => command line access
- `cd  /AutoGraderExamples`
- `cucumber install` => installs gems and rag directory
- `cucumber`         => runs tests
- other vagrant commands are `vagrant halt` => stopping, and `vagrant destroy` => permanently delete VM
- Problems? Send a pull request, it's a great advantage of the vagrant paradigm.


#### **Git-immersion Note:** For deployment, and feature tests using Octokit.client over 60/hr, you must do this!
- The OAuth ENV var `GIT_IMMERSION_TOKEN` used in mvp_spec.rb allows 5000/hr rate limit, whereas anonymous Octokit calls allow 60/hr.
- If not set, it will try to use anonymous connect. Pull requests from forks to AgileVentures/AutoGraderExamples are detected and try to use the anonymous connect.

#### To gain access to a higher rate limit:
- Generate the token on GitHub > Settings > Applications > Personal API Token with **Zero Scopes**. Uncheck all boxes to allow only read access of public data.
- For production deployment and Your local, it is set by admin (you?), eg in /etc/environment and start a new shell.
- For travis CI, it has been encrypted and added to .travis.yml under env:global:secure
- It is encrypted with `gem install travis && travis encrypt GIT_IMMERSION_TOKEN=<a token>`

### **Run:**
- `cucumber` runs a feature per homework.
- `cucumber features/git_immersion_testing.feature` runs a single feature.

==================

**Directories:**
- git-immersion: homework added by instructor
  - autograder: tests run on student submissions, one per courseware section
  - public: skeletons and readmes included in courseware
  - solutions: instructor answers to homework problems, one with full score
- features: integration testing features, one per homework added by instructor
  - step_definitions: one per feature with similar name
- install: autograder installer infrastructure

**Naming conventions:**
 - top-level homework directory: 'boxcar-case'
 - integration features: 'snake_case' ending in 'testing'
