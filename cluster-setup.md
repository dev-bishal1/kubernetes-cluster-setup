<!-- STEPS TO SET UP KUBERNETES CLUSTER -->

<!-- CLUSTER INFORMATION -->
1. We will have a 3-node cluster where one node acts as a master node, and the other two nodes act as worker nodes.
2. All our workloads will run on worker nodes as containers, and components that control our cluster will run on our master node.

<!-- Requirements Before Setting Up Cluster -->
1. One or more machines running a deb/rpm-compatible Linux OS; for example: Ubuntu or CentOS.
2. 2 GiB or more of RAM per machine—any less leaves little room for your apps.
3. At least 2 CPUs on the machine that you use as a control-plane node.
4. Full network connectivity among all machines in the cluster. You can use either a public or a private network.

<!-- Steps For Configuring And Running Virtual Machine -->
1. Since we need 3 Virtual Machines (VM), we must have VirtualBox installed on our Operating System (OS). First of all, install the desired VirtualBox that supports your current OS. Here is the link for downloading VirtualBox: https://www.virtualbox.org/wiki/Downloads

2. After installing VirtualBox, run 3 Virtual Machines that run the Linux OS. You can choose your desired Linux distro, but for this setup, we will be using Ubuntu 2020.

3. Since configuring VirtualBox manually is a hectic task, we will automate this process using Vagrant. Vagrant is an open-source software product for building and managing virtualized development environments. It provides a command-line interface and configuration files to automate the setup of virtual machines, making it easier for developers to create reproducible and portable development environments across different platforms. You can learn more about it by reading the docs: https://developer.hashicorp.com/vagrant/docs

4. Now, install Vagrant on our host OS. Here is the link for downloading Vagrant: https://developer.hashicorp.com/vagrant/downloads

5. After successfully installing Vagrant, it's time to run some commands that will create and run 3 Virtual Machines, which we will later use to configure our Kubernetes Cluster.

<!-- Steps to follow to create and run Virtual Machines: -->
1. Open your desired terminal.
2. Navigate to this folder.
3. Go through the Vagrantfile to understand what is happening behind the scenes and to debug any issues that you might face.
4. Finally, run `vagrant up` in the terminal, and it will create and run 3 Virtual Machines for us.
5. Now, you can check if the 3 Virtual Machines have been actually created or not by running `vagrant status`. Note: You must run this command from this location; otherwise, you might not get the status of your Virtual Machines.
6. After seeing the status, and if the VMs are running, it's time to log in to the VM. For this, you can use `vagrant ssh <name of the VM>`. In this case, we have three VMs with the names: `master, node01, and node2`. You can check the name of these VMs by looking through the Vagrantfile. You can visit this link to learn about various Vagrant-related commands: https://gist.github.com/wpscholar/a49594e2e2b918f4d0c4

<!-- Steps To Follow To Configure Kubernetes Cluster -->
1. First, log in to the master node using `vagrant ssh master` and change the hostname from `vagrant` to `master`. Do the same for `node01` and `node02` respectively, and change their hostname to `node01` and `node02` from `vagrant`. The reason for doing this is that Kubernetes uses hostnames to identify and communicate with nodes (VM).

2. After doing this, we have to disable swap on each machine. For this, run `sudo vi /etc/fstab` and comment out the swap line. You can read about the reason behind doing it here: https://serverfault.com/questions/881517/why-disable-swap-on-kubernetes

3. Now, run `sudo vi /etc/containerd/config.toml` and comment out this line `disabled_plugins = ["cri"]` and save the file. You have to do it on each node. You can view `vi_cheat_sheet.pdf` for vi editor-related commands.

4. After saving the file, restart the containerd service by running `sudo systemctl restart containerd`.

<!-- Finally, after completing all these steps successfully, it's time to create a Kubernetes Cluster: -->

1. Run this command in the terminal: `kubeadm init --apiserver-advertise-address=192.168.33.17 --pod-network-cidr=10.244.0.0/16`, and you will get something like this below:

<!-- 
Your Kubernetes control-plane has initialized successfully! 

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

You should now deploy a Pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  /docs/concepts/cluster-administration/addons/

You can now join any number of machines by running the following on each node
as root:

kubeadm join <control-plane-host>:<control-plane-port> --token <token> --discovery-token-ca-cert-hash sha256:<hash>
 -->

2. Copy `mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config` this part and paste it in the terminal.

3. Store this `kubeadm join <control-plane-host>:<control-plane-port> --token <token> --discovery-token-ca-cert-hash sha256:<hash>` somewhere because we need it later. Note: You should copy your own token that will get generated, not this one.

4. Run this in the terminal of the master node: `kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml`

5. Now, login to each worker node using `vagrant ssh <nodename>` and paste the above-copied token in the terminal. Note you must be the root user or use `sudo` while executing the above stored token in the terminal. Do the same for all the worker nodes that you have.

6. Now, run `kubectl get nodes`, and you should see all the worker nodes that have joined your cluster. In this case, we should have three nodes, one master and two workers.