#!/bin/bash
source common.sh
# Variables 
componenet=catalogue
log=/tmp/roboshop.log

# Enable NodeJs 18 module 
# shellcheck disable=SC2129
dnf module enable nodejs:18 -y | bash &>> $log

# Install the nodejs module 
dnf install nodejs -y | bash &>> $log

# Add an application user 
useradd roboshop | bash &>> $log

# Create an application directory 
mkdir $app_path | bash &>> $log

# Download the appliction code to the above created directory
curl -o /tmp/$componenet.zip https://roboshop-artifacts.s3.amazonaws.com/$componenet.zip | bash &>> $log
# shellcheck disable=SC2164
cd $app_path | bash &>> $log
# shellcheck disable=SC2129
unzip /tmp/$componenet.zip | bash &>> $log
# shellcheck disable=SC2164
cd $app_path | bash &>> $log
npm install | bash &>> $log

# Copy $componenet service file 
cp ../service-files/$componenet.service /etc/systemd/system/ | bash &>> $log

# replace the MongoDB-Server-IP address here 
sed -i '' 's/127.0.0.0/IP-Address/' /etc/systemd/system/$componenet.service | bash &>> $log

# Resload the daemon, enable and start servie 
systemctl daemon-reload | bash &>> $log
systemctl start $componenet | bash &>> $log

# Copy the MongoDB repo file, Install the MongoDB client and load the schema 
cp ../repo-files/mongodb.repo /etc/yum.repos.d/ | bash &>> $log
dnf install mongodb-org-shell -y | bash &>> $log
mongo --host "mongodb-server-ip-address" </app/schema/$componenet.js | bash &>> $log

# Udate $componenet server ip address in frontend configuration <roboshop.conf>
