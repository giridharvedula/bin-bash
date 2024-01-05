#!/bin/bash

# Install Paython 3.6, GCC and Python devel
dnf install python36 gcc python-devel -y

# Add user to configure the application
useradd roboshop

# Download the appliction code to the above created directory
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip 
cd /app 
unzip /tmp/payment.zip

# Install the dependencies 
cd /app
pip 3.6 install -r requirements.txt

# Copy catalogue service file 
cp ../service-files/payment.service /etc/systemd/system/

# Replace the cart server IP and port, user server IP and port and rabbitmq server IP and Port addresses of the actual component
sed -i '' 's/127.0.0.0/<IP-Address/' /etc/systemd/system/cart.service

# Reload the deamon, enable and start the servie 
systemctl daemon-reload
systemctl enable payment
systemctl start payment

# Udate catalogue server ip address in frontend configuration <roboshop.conf>
