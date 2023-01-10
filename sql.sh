source common.sh
if [ -z "${root_set_password}" ];then
  echo "root_set_password is missing"
  exit
fi

print_head "Disable Mysql module"
dnf module disable mysql -y  &>>${LOG}
status_check

print_head "changing Dir of command"
cp ${script_location}/files/mysql-roboshop.conf /etc/yum.repos.d/mysql.repo &>>${LOG}
status_check

print_head "Install Mysql"
yum install mysql-community-server -y &>>${LOG}
status_check

print_head "Enable Mysql"
systemctl enable mysqld &>>${LOG}
status_check

print_head "Start Mysql"
systemctl start mysqld &>>${LOG}
 status_check

print_head "Change password"
mysql_secure_installation --set-root-pass ${root_set_password} &>>${LOG}
 status_check