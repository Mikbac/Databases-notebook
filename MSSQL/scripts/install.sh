#!/bin/bash

# Adding public key
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

# Adding APT repository
sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/18.04/mssql-server-2017.list)"

# Updating repository
sudo apt-get update

# Installing server
sudo apt-get install -y mssql-server
