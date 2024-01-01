#!/bin/bash
app_path=/app
log_path=/tmp/roboshop.log

nodejs() {

    # Enable NodeJs 18 module 
    dnf module enable nodejs:18 -y | bash &>> $log

    # Install the nodejs module 
    dnf install nodejs -y | bash &>> $log

    # Add an application user 
    useradd roboshop | bash &>> $log

    # Create an application directory 
    mkdir $app_path | bash &>> $log

    # Download the appliction code to the above created directory
    curl -o /tmp/$componenet.zip https://roboshop-artifacts.s3.amazonaws.com/$componenet.zip | bash &>> $log
    # shellcheck disable=SC2164
    cd $app_path | bash &>> $log
    # shellcheck disable=SC2129
    unzip /tmp/$componenet.zip | bash &>> $log
    # shellcheck disable=SC2164
    cd $app_path | bash &>> $log
    npm install | bash &>> $log

}