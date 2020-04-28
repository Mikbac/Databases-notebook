#!/bin/bash

wget -qO- https://packages.microsoft.com/config/ubuntu/18.04/prod.list | sudo tee /etc/apt/sources.list.d/msprod.list
sudo apt-get update
wget http://launchpadlibrarian.net/431858050/multiarch-support_2.29-0ubuntu3_amd64.deb
sudo dpkg -i multiarch-support_2.29-0ubuntu3_amd64.deb
sudo apt-get install -y mssql-tools
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >>~/.bash_profile
source ~/.bash_profile
sqlcmd -?
