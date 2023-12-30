#!/bin/bash

# Install the NodeJS 18
dnf module enable nodejs:18 -y
dnf install nodejs -y

# Add application user 
useradd roboshop

# Create a App directory
mkdir /app

# Download the application code
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app ||
unzip /tmp/user.zip

# Install NPM dependencie 
cd /app ||
npm install

# Copy the user service file
cp ../service-files/user.service /etc/systemd/system/
# Replace the Redis and MongoDB IP Addresses of the actual server component
sed -i '' 's/127.0.0.0/<IP-Address/' /etc/systemd/system/user.service

# Reload the deamon, enable and start the servie 
systemctl daemon-reload
systemctl enable user
systemctl start user

# Copy the MongoDB repo file, Install the MongoDB client and load the schema 
cp ../repo-files/mongodb.repo /etc/yum.repos.d/
dnf install mongodb-org-shell -y 
mongo --host mongodb-server-ip-address </app/schema/user.js

# Udate catalogue server ip address in frontend configuration <roboshop.conf>
