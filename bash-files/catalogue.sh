#!/bin/bash

# Enable NodeJs 18 module 
dnf module enable nodejs:18 -y

# Install the nodejs module 
dnf install nodejs -y

# Add an application user 
useradd roboshop 

# Create an application directory 
mkdir /app

# Download the appliction code to the above created directory
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app ||
unzip /tmp/catalogue.zip
cd /app || 
npm install

# Copy catalogue service file 
cp ../service-files/catalogue.service /etc/systemd/system/

# replace the MongoDB-Server-IP address here 
sed -i '' 's/127.0.0.0/<IP-Address/' /etc/systemd/system/catalogue.service

# Resload the daemon, enable and start servie 
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue 

# Copy the MongoDB repo file, Install the MongoDB client and load the schema 
cp ../repo-files/mongodb.repo /etc/yum.repos.d/
dnf install mongodb-org-shell -y
mongo --host "mongodb-server-ip-address" </app/schema/catalogue.js

# Udate catalogue server ip address in frontend configuration <roboshop.conf>

