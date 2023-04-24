script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/sh-files/common.sh

curl -sL https://rpm.nodesource.com/setup_lts.x | bash

yum install nodejs -y

useradd ${app_user}

mkdir /app 

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip 
cd /app 

unzip /tmp/catalogue.zip

cd /app 
npm install 

cp catalogue.service /etc/systemd/system/catalogue.service

systemctl daemon-reload

systemctl enable catalogue 
systemctl start catalogue

cp mongodb.repo /etc/yum.repos.d/mongodb.repo

yum install mongodb-org-shell -y

mongo --host MONGODB-SERVER-IPADDRESS </app/schema/catalogue.js

