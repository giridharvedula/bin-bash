#!/bin/bash

# Configure Redis RPM repo file and enable Redus 6.2 module for installation 
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
dnf module enable redis:remi-6.2 -y 
dnf install redis -y

# Update the Redis conf file to listen 127.0.0.0 > 0.0.0.0
sed -i '' 's/127.0.0.0/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf 

# Enable and Start Redis service 
systemctl enable redis
systemctl start redis

