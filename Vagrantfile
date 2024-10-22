# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  BASE_NETWORK = "192.168.56" 
  config.ssh.insert_key = false 
  config.vm.define "web", primary: true do |web|
    web.vm.box = "ubuntu/jammy64"

    web.vm.network "forwarded_port", guest: 22, host: 2222, id: "ssh"
    web.vm.hostname = "web-host"
    web.vm.network "private_network",ip: "#{BASE_NETWORK}.110", 
      name: "VirtualBox Host-Only Ethernet Adapter", auto_config: false
    web.vm.network "private_network", ip: "10.10.20.10", netmask: 24,
      virtualbox__intnet: "intnet"
    web.vm.provision "shell", path: "scripts/web-install.sh"
    web.vm.provision "shell", path: "scripts/ho-setup.sh"
    web.vm.provider "virtualbox" do |vb|
      vb.name = "WebHost"
      vb.memory = "1024"
      vb.cpus = 2
    end
  end

  config.vm.define "db" do |db|
    db.vm.box = "ubuntu/jammy64"

    db.vm.hostname = "db-host"
    db.vm.network "forwarded_port", guest: 22, host: 2223, id: "ssh"
    db.vm.network "private_network", ip: "10.10.20.11", netmask: 24,
      virtualbox__intnet: "intnet"
    db.vm.provision "shell", path: "scripts/db-install.sh"
    db.vm.provider "virtualbox" do |vb|
      vb.name = "DBHost"
      vb.memory = "1024"
      vb.cpus = 2
    end
  end
end
