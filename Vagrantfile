# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos/7"
  config.vm.hostname = "db2-box"

  config.vm.network :private_network, ip: "192.168.56.70"
  config.vm.network "forwarded_port", guest: 50000, host: 50000
  config.vm.provision :shell, :path => "provision.sh"


  config.vm.provider "virtualbox" do |vb|
        vb.name = "db2-box"
        vb.memory = 4096
        vb.cpus = 2
        vb.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
  end

  config.vm.synced_folder ".", "/vagrant"

end
