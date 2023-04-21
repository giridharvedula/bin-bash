script_path=$(dirname $0)
source ${script_path}/common.sh

echo -e "\e[36m>>>>>>>>> Copy MongoDB Repo file <<<<<<<<\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>>>>> Copy MongoDB Repo file <<<<<<<<\e[0m"
yum install mongodb-org -y 
systemctl enable mongod 
systemctl start mongod 

echo -e "\e[36m>>>>>>>>> editing the local host IP <<<<<<<<\e[0m"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf

echo -e "\e[36m>>>>>>>>> Restart the mongodb and enable <<<<<<<<\e[0m"
systemctl restart mongod
