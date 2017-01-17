#!/bin/bash
sudo apt-get update
sudo apt-get install -y git --no-install-recommends
FILE="/vagrant/chefdk_0.19.6-1_amd64.deb"
if [ -f "$FILE" ]; then
  sudo dpkg -i /vagrant/chefdk_0.19.6-1_amd64.deb
else
  wget -O /vagrant/chefdk_0.19.6-1_amd64.deb https://packages.chef.io/files/stable/chefdk/0.19.6/ubuntu/12.04/chefdk_0.19.6-1_amd64.deb
  sudo dpkg -i /vagrant/chefdk_0.19.6-1_amd64.deb
fi

TERM=xterm-256color chef verify
chef generate repo chef-repo
cd chef-repo
mkdir -p .chef

git config --global user.name mcheriyath
git config --global user.email mcheriyath@pk.com
cp /vagrant/mcheriyath.pem /home/vagrant/chef-repo/.chef/
cp /vagrant/pk.pem /home/vagrant/chef-repo/.chef/
cd /home/vagrant/chef-repo
git init
echo ".chef" > .gitignore
echo "*.pem" >> .gitignore
git add .
git commit -m "initial commit"
cat << EOF > /home/vagrant/chef-repo/.chef/knife.rb
log_level                :info
log_location             STDOUT
node_name                'mcheriyath'
client_key               '/home/vagrant/chef-repo/.chef/mcheriyath.pem'
validation_client_name   'pk-validator'
validation_key           '/home/vagrant/chef-repo/.chef/pk.pem'
chef_server_url          'https://chefserver/organizations/pk'
syntax_check_cache_path  '/home/vagrant/chef-repo/.chef/syntax_check_cache'
cookbook_path [ '/home/vagrant/chef-repo/cookbooks' ]
EOF

knife ssl fetch
knife client list
