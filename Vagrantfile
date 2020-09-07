# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box = "debian/buster64"
    config.vm.box_version = "10.4.0"
    config.vm.box_check_update = true
    config.ssh.forward_agent = true
    config.ssh.forward_x11 = true
  
    # Create a forwarded port mapping which allows access to a specific port
    # within the machine from a port on the host machine. In the example below,
    # accessing "localhost:8080" will access port 80 on the guest machine.
    # NOTE: This will enable public access to the opened port
    # config.vm.network "forwarded_port", guest: 80, host: 8080
  
    # Create a forwarded port mapping which allows access to a specific port
    # within the machine from a port on the host machine and only allow access
    # via 127.0.0.1 to disable public access
    # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  
    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    # config.vm.network "private_network", ip: "192.168.33.10"
  
    # Create a public network, which generally matched to bridged network.
    # Bridged networks make the machine appear as another physical device on
    # your network.
    # config.vm.network "public_network"
  
    # Share an additional folder to the guest VM. The first argument is
    # the path on the host to the actual folder. The second argument is
    # the path on the guest to mount the folder. And the optional third
    # argument is a set of non-required options.
    config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
  
    config.vm.provider "virtualbox" do |vb|
      vb.gui = true
      vb.customize ["modifyvm", :id, "--vram", "12"]
      # Customize the amount of memory on the VM:
      vb.memory = "4096"
    end
    config.vm.provision "shell", inline: <<-SHELL
      export DEBIAN_FRONTEND=noninteractive
      apt-get update
      apt-get install -y xfce4
      sed -i 's/allowed_users=.*$/allowed_users=anybody/' /etc/X11/Xwrapper.config
      apt-get install -y wget vim curl xauth openjdk-11-jdk unzip
      echo PATH='$PATH':/home/vagrant/.bin >> /home/vagrant/.bashrc
      echo PATH='$PATH':/usr/lib/jvm/java-11-openjdk-amd64 >> /home/vagrant/.bashrc
      echo "Downloading Ghidra ..."
      wget -q --progress=bar:force https://ghidra-sre.org/ghidra_9.1.2_PUBLIC_20200212.zip
      unzip ghidra_9.1.2_PUBLIC_20200212.zip
      rm -rf *.zip
      mkdir -p /home/vagrant/.bin
      mkdir -p /home/vagrant/Applications
      mv $(pwd)/ghidra_9.1.2_PUBLIC /home/vagrant/Applications
      ln -sf /home/vagrant/Applications/ghidra_9.1.2_PUBLIC/ghidraRun /home/vagrant/.bin/ghidra
      # XFCE autologin
      echo "[Seat:*]" >> /etc/lightdm/lightdm.conf
      echo "autologin-user=vagrant" >> /etc/lightdm/lightdm.conf
      # Desktop icon
      mkdir -p /home/vagrant/Desktop/
      cp /vagrant/ghidra.desktop /home/vagrant/Desktop/
      chown vagrant:vagrant /home/vagrant/Desktop/ghidra.desktop
      chmod 755 /home/vagrant/Desktop/ghidra.desktop
      cp /vagrant/ghidra.png /home/vagrant/Applications/ghidra_9.1.2_PUBLIC/ghidra.png

      apt-get clean
      apt-get autoremove --purge
    SHELL
end
