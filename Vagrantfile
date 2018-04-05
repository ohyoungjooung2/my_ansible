# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

   config.vm.define "ct7vag" do |ct7vag|
   ct7vag.vm.box = "centos/7"
   ct7vag.vm.provision "shell", inline: "cat /vagrant/pub_key >> /home/vagrant/.ssh/authorized_keys"
   ct7vag.vm.network "private_network", ip:"10.0.0.5"
   
   ct7vag.vm.host_name = "ct7vag"
     ct7vag.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024"]
     end
   end

   
   config.vm.define "ct6vag" do |ct6vag|
   ct6vag.vm.box = "centos/6"
   ct6vag.vm.provision "shell", inline: "cat /vagrant/pub_key >> /home/vagrant/.ssh/authorized_keys"
   ct6vag.vm.network "private_network", ip:"10.0.0.6"
   ct6vag.vm.host_name = "ct6vag"
     ct6vag.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
     end
   end

   config.vm.define "u16vag" do |u16vag|
   u16vag.vm.box = "ubuntu/xenial64"
   u16vag.vm.network "private_network", ip:"10.0.0.7"
   u16vag.vm.host_name = "u16vag"
     u16vag.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
     end
   end


   
   config.vm.define "ct6test" do |ct6test|
   ct6test.vm.box = "centos/6"
   ct6test.vm.network "private_network", ip:"10.0.0.8"
   ct6test.vm.host_name = "ct6test"
     ct6test.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
     end
   end

end
