#!/bin/bash

# installing nging server 
yum install nginx -y

# enble and start ngin server 
systemctl enable nginx
systemctl start nginx 

# removing files from nginx host location 
rm -rf /usr/share/nginx/html/*

# Download the frontend content 
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

# Change to Nginx directory and extract the frontend content 
cd /usr/share/nginx/html ||
unzip /tmp/frontend.zip

# Copy Nginx reverse proxy configuration file
cp cd ../roboshop.conif /etc/nginx/default.d/

# Restart Nginx server to reload the changes
systemctl restart nginx
