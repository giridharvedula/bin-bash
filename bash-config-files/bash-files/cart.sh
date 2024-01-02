#!/bin/bash

# Variable
component=cart

# Enable NodeJs 18 module and install 
dnf module enable nodejs:18 
dnf install nodejs -y 

# Add an application user 
useradd roboshop 

# Create an app directory, download code from source URL and unzip.
mkdir /app 
curl -L -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip 
cd /app  
unzip /tmp/$component.zip 

# Install app dependency NPM
cd /app 
npm install 

# Copy the ${component} servie file
cp "/bash-config-files/service-files/$component.service" "/etc/systemd/system/"

# Replace the Redis IP, Catalogue IP and Port addresses of the actual component
sed -i '' 's/127.0.0.0/IP-Address/' /etc/systemd/system/$component.service 

# Reload the deamon, enable and start the servie 
systemctl daemon-reload 
systemctl enable $component.service 
systemctl start $component.service 

# Udate catalogue server ip address in frontend configuration <roboshop.conf>
