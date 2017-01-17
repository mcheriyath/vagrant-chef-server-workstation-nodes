#!/bin/bash
FILE="/vagrant/chef-server-core_12.9.1-1_amd64.deb"
if [ -f "$FILE" ]; then
  sudo dpkg -i /vagrant/chef-server-core_12.9.1-1_amd64.deb
else
  wget -O /vagrant/chef-server-core_12.9.1-1_amd64.deb  https://packages.chef.io/stable/ubuntu/12.04/chef-server-core_12.9.1-1_amd64.deb
  sudo dpkg -i /vagrant/chef-server-core_12.9.1-1_amd64.deb
fi

sudo chef-server-ctl reconfigure
mkdir -p /home/vagrant/.chef
sudo chef-server-ctl user-create mcheriyath Mithun Cheriyath mcheriyath@pk.com password --filename /home/vagrant/.chef/mcheriyath.pem
sudo chef-server-ctl org-create pk prokarma --association_user mcheriyath --filename /home/vagrant/.chef/pk.pem
sudo chef-server-ctl install chef-manage
sudo chef-server-ctl reconfigure

USERPEM="/vagrant/mcheriyath.pem"
if [ -f "$USERPEM" ]
then
  rm /vagrant/mcheriyath.pem
  cp /home/vagrant/.chef/mcheriyath.pem /vagrant/mcheriyath.pem
else
  cp /home/vagrant/.chef/mcheriyath.pem /vagrant/mcheriyath.pem
fi

ORGPEM="/vagrant/pk.pem"
if [ -f "$ORGPEM" ]
then
  rm /vagrant/pk.pem
  cp /home/vagrant/.chef/pk.pem /vagrant/pk.pem
else
  cp /home/vagrant/.chef/pk.pem /vagrant/pk.pem
fi

sudo chef-manage-ctl reconfigure --accept-license
