#!/bin/bash

# Install the GoLang
dnf install golang -y

# Add appplication user
useradd roboshop

# Download the appliction code to the above created directory
mkdir /app
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip 
cd /app
unzip /tmp/dispatch.zip

# Install the dependencies 
cd /app
go mod init dispatch
go get 
go build

# Copy dispatch service file 
cp ..//service-files/dispatch.service /etc/systemd/system
# Replace the RabbitMQ IP addresses of the actual component
sed -i '' 's/127.0.0.0/IP-Address/' /etc/systemd/system/cart.service

# Reload the deamon, enable and start the servie 
systemctl daemon-reload
systemctl enable dispatch
systemctl restart dispatch
