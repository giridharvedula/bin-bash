script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/sh-files/common.sh

dnf module disable mysql -y 

cp /repo-files/mongodb.repo /etc/yum.repos.d/mysql.repo

yum install mysql-community-server -y

systemctl enable mysqld
systemctl start mysqld  

mysql_secure_installation --set-root-pass RoboShop@1
