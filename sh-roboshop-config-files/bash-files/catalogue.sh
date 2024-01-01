#!/bin/bash
source common.sh
# Variables 
component=catalogue

# Enable NodeJs 18 module and install 
dnf module enable nodejs:18 -y | bash &>>${log_path}
dnf install nodejs -y | bash &>>${log_path}

# Add an application user 
useradd roboshop | bash &>>${log_path}

# Create an app directory, download code from source URL and unzip.
mkdir ${app_path} | bash &>>${log_path}
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip | bash &>>${log_path}
cd ${app_path} | bash &>>${log_path}
unzip /tmp/${component}.zip | bash &>>${log_path}

# Install app dipendecy NPM 
cd ${app_path} | bash &>>${log_path}
npm install | bash &>>${log_path}

# Copy ${component} service file 
cp ../service-files/${component}.service /etc/systemd/system/ | bash &>>${log_path}

# replace the MongoDB-Server-IP address here 
sed -i '' 's/127.0.0.0/IP-Address/' /etc/systemd/system/${component}.service | bash &>>${log_path}

# Resload the daemon, enable and start servie 
systemctl daemon-reload | bash &>>${log_path}
systemctl enable ${component} | bash &>>${log_path}
systemctl start ${component} | bash &>>${log_path}

# Copy the MongoDB repo file, Install the MongoDB client and load the schema 
cp ../repo-files/mongodb.repo /etc/yum.repos.d/ | bash &>>${log_path}
dnf install mongodb-org-shell -y | bash &>>${log_path}
mongo --host "mongodb-server-ip-address" </app/schema/${component}.js | bash &>>${log_path}

# Udate ${component} server ip address in frontend configuration <roboshop.conf>
