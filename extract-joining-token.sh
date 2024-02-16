cat cluster-setup.txt | grep -i 'kubeadm join' > token.sh
cat cluster-setup.txt | grep -i 'discovery-token' >> token.sh

sed -i 's/kubeadm/sudo kubeadm/' token.sh

sudo chmod +x token.sh

