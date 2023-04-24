script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/sh-files/common.sh

cp ${script_path}/repo-files/mongodb.repo /etc/yum.repos.d/mongo.repo

yum install mongodb-org -y 
systemctl enable mongod 
systemctl start mongod

sed -i -e ':çs|127.0.0.1|0.0.0.0|' /etc/mongod.conf

systemctl restart mongod
