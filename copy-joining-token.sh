cd ~
scp -i /vagrant/.vagrant/machines/node01/virtualbox/private_key token.sh vagrant@node01:/home/vagrant
scp -i /vagrant/.vagrant/machines/node02/virtualbox/private_key token.sh vagrant@node02:/home/vagrant