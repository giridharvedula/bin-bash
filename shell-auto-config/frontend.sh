script_path=$(dirname $0)
source ${script_path}/common.sh

echo -e "\e[36m>>>>>>>>> Install Nginx <<<<<<<<\e[0m"
yum install nginx -y

echo -e "\e[36m>>>>>>>>> Copy roboshop file <<<<<<<<\e[0m"
cp roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[36m>>>>>>>>> Remove Nginx default HTML files <<<<<<<<\e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[36m>>>>>>>>> curl Roboshop artifacts <<<<<<<<\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[36m>>>>>>>>> Nginx HTML directory <<<<<<<<\e[0m"
cd /usr/share/nginx/html

echo -e "\e[36m>>>>>>>>> unzip frontend <<<<<<<<\e[0m"
unzip /tmp/frontend.zip

echo -e "\e[36m>>>>>>>>> Restart and enable the nginx server services <<<<<<<<\e[0m"
systemctl enable nginx
systemctl restart nginx
