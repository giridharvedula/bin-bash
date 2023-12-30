#!/bin/bash
source common.sh
# installing nging server 
yum install nginx -y | bash &>> $log

# enble and start ngin server 
systemctl enable nginx | bash &>> $log
systemctl start nginx | bash &>> $log

# removing files from nginx host location 
rm -rf /usr/share/nginx/html/* | bash &>> $log

# Download the frontend content 
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip | bash &>> $log

# Change to Nginx directory and extract the frontend content 
cd /usr/share/nginx/html | bash &>> $log
unzip /tmp/frontend.zip | bash &>> $log

# Copy Nginx reverse proxy configuration file
cp ../roboshop.conif /etc/nginx/default.d/ | bash &>> $log

# Restart Nginx server to reload the changes
systemctl restart nginx | bash &>> $log