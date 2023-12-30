#!/bin/bash

# Install Maven 
dnf install maven 

# Configure the application
useradd roboshop

# Create an app directory, download code from source URL and unzip.
mkdir /app
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app ||
unzip /tmp/shipping.zip

# Build the package from the source code downloaded
cd /app ||
mvn clean package
mv target/shipping-1.0.jar shipping.jar

# Copy the user service file
cp ../service-files/shipping.service /etc/systemd/system/
# Replace the Cart IP, MySQL IP addresses of the actual component
sed -i '' 's/127.0.0.0/IP-Address/' /etc/systemd/system/cart.service

# Reload the deamon, enable and start the servie 
systemctl daemon-reload
systemctl enable shipping
systemctl start shipping

# Disable default MySQL 8, add MySQL 5.7 repo and install it
dnf module mysql -y
cp ../repo-files/mysql.repo /etc/yum.repos.d/
dnf install mysql -y 

# Load schema
mysql -h "MYSQL-SERVER-IPADDRESS" -uroot -pRoboShop@1 < /app/schema/shipping.sql

# Restart shipping 
systemctl restart shipping

# Udate catalogue server ip address in frontend configuration <roboshop.conf>