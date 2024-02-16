# Note: If you get network bridge error simply remove bridge: "en0: Wi-Fi (AirPort)" and rerun the command.

Vagrant.configure("2") do |config|
    # Enable and configure hostmanager plugin for managing host entries.
    config.hostmanager.enabled = true 
    config.hostmanager.manage_host = true

    # Configuration for the master node.
    config.vm.define "master" do |master|
        # Set the base box for the master node.
        master.vm.box = "geerlingguy/ubuntu2004"
        
        # Define private network settings for the master node.
        master.vm.network "private_network", ip: "192.168.33.17"
        
        # Define public network settings for the master node using Wi-Fi (AirPort) bridge.
        # Note: This might be different in your OS so go through your network interface 
        # and select the one that let your virtual machine connect to the external network
        master.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)"
        
        # RAM and CPU configuration
        master.vm.provider "virtualbox" do |vb1|
            vb1.memory = '2500'
            vb1.cpus = 2
        end
        
        # Provisioning script for setting up the master node.
        master.vm.provision "shell", path: "cluster-setup.sh"
        master.vm.provision "shell", path: "change-hostname.sh", args: ["master"]
        master.vm.provision "shell", path: "disable-swap.sh"
        master.vm.provision "shell", path: "disable-cri-plugin.sh"
        master.vm.provision "shell", path: "kubeadm-init.sh"
        # master.vm.provision "shell", path: "extract-joining-token.sh"
    end

    # Configuration for node01.
    config.vm.define "node01" do |node01|
        # Set the base box for node01.
        node01.vm.box = "geerlingguy/ubuntu2004"
        
        # Define private network settings for node01.
        node01.vm.network "private_network", ip: "192.168.33.18"
        
        # Define public network settings for node01 using Wi-Fi (AirPort) bridge.
        # Note: This might be different in your OS so go through your network interface 
        # and select the one that let your virtual machine connect to the external network
        node01.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)"
        
        # RAM and CPU configuration
        node01.vm.provider "virtualbox" do |vb2|
            vb2.memory = '1500'
            vb2.cpus = 2
        end
        
        # Provisioning script for setting up node01.
        node01.vm.provision "shell", path: "cluster-setup.sh"
        node01.vm.provision "shell", path: "change-hostname.sh", args: ["node01"]
        node01.vm.provision "shell", path: "disable-swap.sh"
        node01.vm.provision "shell", path: "disable-cri-plugin.sh"
    end

    # Configuration for node02.
    config.vm.define "node02" do |node02|
        # Set the base box for node02.
        node02.vm.box = "geerlingguy/ubuntu2004"
        
        # Define private network settings for node02.
        node02.vm.network "private_network", ip: "192.168.33.19"
        
        # Define public network settings for node02 using Wi-Fi (AirPort) bridge.
        # Note: This might be different in your OS so go through your network interface 
        # and select the one that let your virtual machine connect to the external network
        node02.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)"
        
        # RAM and CPU configuration
        node02.vm.provider "virtualbox" do |vb3|
            vb3.memory = '3000'
            vb3.cpus = 2
        end
        
        # Provisioning script for setting up node02.
        node02.vm.provision "shell", path: "cluster-setup.sh"
        node02.vm.provision "shell", path: "change-hostname.sh", args: ["node02"]
        node02.vm.provision "shell", path: "disable-swap.sh"
        node02.vm.provision "shell", path: "disable-cri-plugin.sh"
        node02.vm.provision "shell", path: "execute-token.sh"
    end
end
