#!/bin/bash
# Variables 
component=catalogue

# Enable NodeJs 18 module and install 
dnf module disable nodejs -y
dnf module enable nodejs:18 -y 
dnf install nodejs -y 


# Add an application user 
useradd roboshop  

# Create an app directory, download code from source URL and unzip.
mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip  
cd /app
unzip /tmp/catalogue.zip  

# Install app dipendecy NPM 
cd /app
npm install  

# Copy ${component} service file 
cp "/bash-config-files/service-files/catalogue.service" "/etc/systemd/system/" 

# Resload the daemon, enable and start servie 
systemctl daemon-reload  
systemctl enable catalogue
systemctl restart catalogue  

# Copy the MongoDB repo file, Install the MongoDB client and load the schema 
cp ../repo-files/mongodb.repo /etc/yum.repos.d/  
dnf install mongodb-org-shell -y  
mongo --host 10.0.2.227 </app/schema/catalogue.js  
