script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/sh-files/common.sh

curl -sL https://rpm.nodesource.com/setup_lts.x | bash

yum install nodejs -y

useradd ${app_user}

mkdir /app 

curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip 
cd /app 
unzip /tmp/user.zip

cd /app 
npm install 

cp ${script_path}/service-files/user.service /etc/systemd/system/user.service

systemctl daemon-reload

systemctl enable user 
systemctl start user

cp ${script_path}/repo-files/mongodb.repo /etc/yum.repos.d/mongo.repo

yum install mongodb-org-shell -y

mongo --host MONGODB-SERVER-IPADDRESS </app/schema/user.js