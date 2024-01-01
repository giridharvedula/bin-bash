#!/bin/bash

# Disable default MySQL 8, add MySQL 5.7 repo and install it
dnf module mysql -y
cp ../repo-files/mysql.repo /etc/yum.repos.d/
dnf install mysql-community-server -y 

# Start MySQL server 
systemctl enable mysqld
systemctl start mysqld

# Set the root password for MySQL 
mysql_secure_installation --set-root-pass RoboShop@1

