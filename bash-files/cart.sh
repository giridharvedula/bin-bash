#!/bin/bash

# Install NodeJS module 18 and install
dnf module enable nodejs:18
dnf install nodejs -y 

# Add an application user 
useradd roboshop

# Create an app directory, download code from source URL and unzip.
mkdir /app
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app ||
unzip /tmp/cart.zip

# Install app dipendecy NPM 
cd /app ||
npm install

# Copy the cart servie file
cp ../service-files/cart.service /etc/systemd/system/
# Replace the Redis IP, Catalogue IP and Port addresses of the actual component
sed -i '' 's/127.0.0.0/IP-Address/' /etc/systemd/system/cart.service



# Reload the deamon, enable and start the servie 
systemctl daemon-reload
systemctl enable cart.service
systemctl start cart.service

# Udate catalogue server ip address in frontend configuration <roboshop.conf>
