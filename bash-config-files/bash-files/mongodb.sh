#!/bin/bash

# Setup MongoDB repo file into the repo directory
cp "/bash-config-files/repo-files/mongodb.repo" "/etc/yum.repos.d/"

# Install MongoDB server by executing below command 
dnf install mongodb-org -y
dnf install unzip -y

# Enable and start MongoDB service 
systemctl enable mongod
systemctl start mongod

# Update the Listen address for MongoDB server
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

# Restar the Mongodb service
systemctl restart mongod
