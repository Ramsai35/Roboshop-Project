script_location=$(pwd)
LOG=/tmp/roboshop.log

echo -e "\e[34m Install NGINX\e[0m"
yum install nginx -y &>>${LOG}
if [ $? -eq 0 ];then
  echo SUCCESS
else
  echo Failure
fi


systemctl enable nginx &>>${LOG}
systemctl start nginx &>>${LOG}

rm -rf /usr/share/nginx/html/* &>>${LOG}

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${LOG}

cd /usr/share/nginx/html &>>${LOG}
unzip /tmp/frontend.zip &>>${LOG}

cp ${script_location}/files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${LOG}

systemctl restart nginx &>>${LOG}