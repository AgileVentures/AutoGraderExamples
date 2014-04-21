# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "hashicorp/precise32"
  config.vm.provision "shell", path: "ubuntu-install.sh"
  config.vm.network :forwarded_port, host: 4567, guest: 80
  config.vm.synced_folder ".", "/AutoGraderExamples"
end
