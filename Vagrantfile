# -*- mode: ruby -*-
# vi: set ft=ruby :

#!! REQUIRES !! vagrant-hostmanager

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.ssh.insert_key = false
  config.vm.box = 'ubuntu/trusty64'
  config.ssh.private_key_path = "~/.vagrant.d/insecure_private_key"
  config.ssh.forward_agent = true

  # Hostmanager config
  config.vm.provision :hostmanager
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = false

config.vm.define "chefserver" do |ubuntu_host1|
    ubuntu_host1.vm.box = "ubuntu/trusty64"
    ubuntu_host1.vm.hostname = 'chefserver'
    ubuntu_host1.vm.box_url = "ubuntu/trusyt64"

    ubuntu_host1.vm.network :private_network, ip: "10.10.0.99"

    ubuntu_host1.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 3078]
      v.customize ["modifyvm", :id, "--name", "chefserver"]
    end
    config.vm.provision "shell", path: "chef-server-core-installation.sh"
  end

  config.vm.define "chefworkstation" do |ubuntu_host2|
    ubuntu_host2.vm.box = "ubuntu/trusty64"
    ubuntu_host2.vm.hostname = 'chefworkstation'
    ubuntu_host2.vm.box_url = "ubuntu/trusty64"

    ubuntu_host2.vm.network :private_network, ip: "10.10.0.100"

    ubuntu_host2.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 2048]
      v.customize ["modifyvm", :id, "--name", "chefworkstation"]
    end
    config.vm.provision "shell", path: "chef-dk-installation.sh"
end

  config.vm.define "chefnode1" do |node1|
    node1.vm.box = "ubuntu/trusty64"
    node1.vm.hostname = 'chefnode1'
    node1.vm.box_url = "ubuntu/trusty64"

    node1.vm.network :private_network, ip: "10.10.0.111"

    node1.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "chefnode1"]
    end
end

  config.vm.define "chefnode2" do |node2|
    node2.vm.box = "centos/7"
    node2.vm.hostname = 'chefnode2'
    node2.vm.box_url = "centos/7"

    node2.vm.network :private_network, ip: "10.10.0.112"

    node2.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "chefnode2"]
    end
end
end
