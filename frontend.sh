source common.sh

print_head "INSTALL NGINX"
yum install nginx -y &>>${LOG}
status_check

print_head "ENABLE NGINX"
systemctl enale nginx &>>${LOG}
status_check

print_head "START NGINX"
systemctl start nginx &>>${LOG}
status_check

print_head "CLEAN UP DIRECTORY"
rm -rf /usr/share/nginx/html/* &>>${LOG}
status_check

print_head "DOWNLOAD WEB CONTENT"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${LOG}
status_check

print_head "CHANGE DIRECTION"
cd /usr/share/nginx/html &>>${LOG}
status_check

print_head "UNZIP"
unzip /tmp/frontend.zip &>>${LOG}
status_check

print_head "REDIRECT TO CONFIG FILE"
cp ${script_location}/files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${LOG}
status_check

print_head "RESTART NGINX"
systemctl restart nginx &>>${LOG}
status_check