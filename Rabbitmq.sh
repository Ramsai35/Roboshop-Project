source common.sh
if [ -z "${roboshop_password}" ];then
  echo "password is missing please enter password"
  exit
fi
print_head "Loading Repo file"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash &>>${LOG}
status_check

print_head "Install ERLANG"
yum install erlang -y &>>${LOG}
status_check

print_head "Configure RabbitMQ"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>${LOG}
status_check

print_head "Install RabbitMQ"
yum install rabbitmq-server -y &>>${LOG}
status_check

print_head "Enable RabbitMQ"
systemctl enable rabbitmq-server &>>${LOG}
status_check

print_head "Start RabbitMQ"
systemctl start rabbitmq-server &>>${LOG}
status_check

print_head "User Add"
rabbitmqctl list_users | grep roboshop &>>${LOG}
if [ $? -ne 0 ];then
  rabbitmqctl add_user roboshop ${roboshop_password} &>>${LOG}
fi
  status_check


print_head "Adiministration Permissions"
rabbitmqctl set_user_tags roboshop administrator &>>${LOG}
status_check

print_head "Permissions"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>${LOG}
status_check
