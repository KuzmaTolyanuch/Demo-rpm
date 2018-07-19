# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.provider :virtualbox do |box|
      box.linked_clone = true
      box.customize [ "modifyvm", :id, "--memory", "2048", "--cpus", "1" ]
  end
  
  config.vm.define :jenkins do |box|
      box.vm.hostname = "jenkins"
      box.vm.box = "centos/7"
      box.vm.network "public_network", ip: "192.168.100.10"
      box.vm.synced_folder ".", "/vagrant"
    
      box.vm.provision :shell,
         :path => "postinstall.sh.sh",
         :args => "master", 
         :preserve_order => true,
         :run => "always"
  end
  
    config.vm.define :devenv do |box|
      box.vm.hostname = "devenv"
      box.vm.box = "centos/7"
      box.vm.network "public_network", ip: "192.168.100.11"
      box.vm.synced_folder ".", "/vagrant"
      
      box.vm.provision :shell,
         :path => "postinstall.sh.sh",
         :args => "devenv", 
         :preserve_order => true,
         :run => "always"

  end
  
      config.vm.define :stageenv do |box|
      box.vm.hostname = "stageenv"
      box.vm.box = "centos/7"
      box.vm.network "public_network", ip: "192.168.100.12"
      box.vm.synced_folder ".", "/vagrant"
      
      box.vm.provision :shell,
         :path => "postinstall.sh.sh",
         :args => "stageenv", 
         :preserve_order => true,
         :run => "always"
    
  end
  
      config.vm.define :qaenv do |box|
      box.vm.hostname = "qaenv"
      box.vm.box = "centos/7"
      box.vm.network "public_network", ip: "192.168.100.13"
      box.vm.synced_folder ".", "/vagrant"

      box.vm.provision :shell,
         :path => "postinstall.sh.sh",
         :args => "qaenv", 
         :preserve_order => true,
         :run => "always"
  end
end
