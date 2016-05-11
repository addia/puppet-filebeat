# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "landregistry/centos"
  config.vm.provision "shell", inline: <<-SCRIPT
    yum install -y git
    puppet module install puppetlabs-vcsrepo
    puppet module install puppetlabs-stdlib
    ln -s /vagrant /etc/puppet/modules/filebeat
  SCRIPT

  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', ENV['VM_MEMORY'] || 2048]
    vb.customize ['modifyvm', :id, '--vram', ENV['VM_VIDEO'] || 24]
    vb.customize ["modifyvm", :id, "--cpus", ENV['VM_CPUS'] || 4]
  end
end
