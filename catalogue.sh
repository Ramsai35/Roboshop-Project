source common.sh

print_head "creating Repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG}
status_check

print_head "Install NodeJS"
yum install nodejs -y &>>${LOG}
status_check

print_head "Add Application User"
  id roboshop &>>${LOG}
  if [ $? -ne 0 ]; then
    useradd roboshop &>>${LOG}
  fi
status_check

print_head "Creating DIrectory"
mkdir -p /app &>>${LOG}
status_check

print_head "Download Web content"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${LOG}
status_check

print_head "Clean Up"
rm -rf /app/* &>>${LOG}
status_check

print_head "Changr dir"
cd /app &>>${LOG}
status_check

print_head "UNZIP"
unzip /tmp/catalogue.zip &>>${LOG}
status_check

print_head "Change DIR"
cd /app &>>${LOG}
status_check

print_head "INSTALL NPM"
npm install &>>${LOG}
status_check


print_head "Change dir"
cp ${script_location}/files/catalogue-roboshop.conf /etc/systemd/system/catalogue.service &>>${LOG}
status_check

print_head "daemonon Load"
systemctl daemon-reload &>>${LOG}
status_check

print_head "enable catalogue"
systemctl enable catalogue &>>${LOG}
status_check

print_head "start catalogue"
systemctl start catalogue &>>${LOG}
status_check

print_head "Install mongodb"
labauto mongodb-client &>>${LOG}
status_check

print_head "schema Load"
mongo --host mongodb.ramdevops35.online </app/schema/catalogue.js &>>${LOG}
status_check