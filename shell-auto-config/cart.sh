script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/sh-files/common.sh

curl -sL https://rpm.nodesource.com/setup_lts.x | bash

yum install nodejs -y

useradd ${app_user}

mkdir /app 

curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip 
cd /app 
unzip /tmp/cart.zip

cd /app 
npm install 

cp ${script_path}/service-files/cart.services /etc/systemd/system/cart.service

systemctl daemon-reload

systemctl enable cart 
systemctl start cart

