#!/bin/bash
sudo systemctl restart kubelet
sudo kubeadm init --apiserver-advertise-address=192.168.33.17 --pod-network-cidr=10.244.0.0/16 &> cluster-setup.txt
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml