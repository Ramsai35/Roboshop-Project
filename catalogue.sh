source common.sh

print_head "Creating Repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG}
status_check

print_head "Creating Repo"
yum install nodejs -y &>>${LOG}
status_check

print_head "Creating Repo"
useradd roboshop &>>${LOG}
status_check

print_head "Creating Repo"
mkdir -p /app &>>${LOG}
status_check

print_head "Creating Repo"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${LOG}
status_check

print_head "Creating Repo"
rm -rf /app/* &>>${LOG}
status_check

print_head "Creating Repo"
cd /app &>>${LOG}
status_check

print_head "Creating Repo"
unzip /tmp/catalogue.zip &>>${LOG}
status_check

print_head "Creating Repo"
cd /app &>>${LOG}
status_check

print_head "Creating Repo"
npm install &>>${LOG}
status_check


print_head "Creating Repo"
cp ${script_location}/files/catalogue-roboshop.conf /etc/systemd/system/catalogue.service &>>${LOG}
status_check

print_head "Creating Repo"
systemctl daemon-reload &>>${LOG}
status_check

print_head "Creating Repo"
systemctl enable catalogue &>>${LOG}
status_check

print_head "Creating Repo"
systemctl start catalogue &>>${LOG}
status_check

print_head "Creating Repo"
labauto mongodb-client &>>${LOG}
status_check

print_head "Creating Repo"
mongo --host mongodb.ramdevops35.online </app/schema/catalogue.js &>>${LOG}
status_check