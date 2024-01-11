#!/bin/bash

# Configure the YUM repos
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

# Install RabbitMQ
dnf install rabbitmq-server -y 

# Enable and Start RabbitMQ service
systemctl enable rabbitmq-server 
systemctl restart rabbitmq-server 

# Create a user name and pass for RabbitMQ 
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" 
