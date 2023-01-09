source common.sh

print_head "changing Dir of command"
cp ${script_location}/files/mongodb-roboshop.conf /etc/yum.repos.d/mongo.repo &>>${LOG}
status_check

print_head "Install MongoDB"
yum install mongodb-org -y &>>${LOG}
status_check

print_head "Changing Port status"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>${LOG}
status_check

print_head "Enable MONGOD"
systemctl enable mongod &>>${LOG}
status_check

print_head "Start MONGOD"
systemctl start mongod &>>${LOG}
status_check

print_head "Start MONGOD"
systemctl restart mongod &>>${LOG}
status_check
