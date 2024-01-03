#!/bin/bash
# installing nging server 
dnf install nginx -y
dnf install unzip -y

# enble and start ngin server 
systemctl enable nginx 
systemctl start nginx 

# removing files from nginx host location 
rm -rf /usr/share/nginx/html/* 

# Download the frontend content 
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip 

# Change to Nginx directory and extract the frontend content 
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

# Copy Nginx reverse proxy configuration file
cp "../roboshop.conf" "/etc/nginx/default.d/"

# Restart Nginx server to reload the changes
systemctl restart nginx 
