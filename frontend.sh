script_location=$(pwd)
LOG=/tmp/roboshop.log
status_check(){
  if [ $? -eq 0 ];then
    echo SUCCESS
  else
    echo Failure
    echo "service got failed for more info refer"- ${LOG}
  fi
}

echo -e "\e[35m Install NGINX\e[0m"
yum install nginx -y &>>${LOG}
status_check

echo -e "\e[35m Start NGINX\e[0m"
systemctl enable nginx &>>${LOG}
status_check

echo -e "\e[35m Start NGINX\e[0m"
systemctl start nginx &>>${LOG}
status_check

echo -e "\e[35m cleanup content\e[0m"
rm -rf /usr/share/nginx/html/* &>>${LOG}
status_check

echo -e "\e[35m Download web contentX\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${LOG}
status_check

echo -e "\e[35m change dir\e[0m"
cd /usr/share/nginx/html &>>${LOG}
status_check

echo -e "\e[35m UNZIP\e[0m"
unzip /tmp/frontend.zip &>>${LOG}
status_check

echo -e "\e[35m change Dir\e[0m"
cp ${script_location}/files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${LOG}
status_check

echo -e "\e[35m Restart NGINX\e[0m"
systemctl restart nginx &>>${LOG}
status_check