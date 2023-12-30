#!/bin/bash

# Setup MongoDB repo file into the repo directory
cp ../repo-files/mongodb.repo /etc/yum.repos.d/

# Install MongoDB server by executing below command 
dnf install mongodb-org -y

# Enable and start MongoDB service 
systemctl enable mongodb
systemctl start mongodb

# Update the Listen address for MongoDB server
sed -i '' 's/127.0.0.0/0.0.0.0/' /etc/mongodb.conf

# Restar the Mongodb service
systemctl restart mongod
