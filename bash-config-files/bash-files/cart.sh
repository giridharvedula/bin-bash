#!/bin/bash
source common.sh
# Variable
component=cart

# Enable NodeJs 18 module and install 
dnf module enable nodejs:18 | bash &>>${log_path}
dnf install nodejs -y | bash &>>${log_path}

# Add an application user 
useradd roboshop | bash &>>${log_path}

# Create an app directory, download code from source URL and unzip.
mkdir /app | bash &>>${log_path}
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip | bash &>>${log_path}
cd /app || exit | bash &>>${log_path}
unzip /tmp/${component}.zip | bash &>>${log_path}

# Install app dependency NPM
cd /app || exit | bash &>>${log_path}
npm install | bash &>>${log_path}

# Copy the ${component} servie file
cp "/bash-config-files/service-files/"${component}".service" "/etc/systemd/system/" | 

# Replace the Redis IP, Catalogue IP and Port addresses of the actual component
sed -i '' 's/127.0.0.0/IP-Address/' /etc/systemd/system/${component}.service | bash &>>${log_path}

# Reload the deamon, enable and start the servie 
systemctl daemon-reload | bash &>>${log_path}
systemctl enable ${component}.service | bash &>>${log_path}
systemctl start ${component}.service | bash &>>${log_path}

# Udate catalogue server ip address in frontend configuration <roboshop.conf>
