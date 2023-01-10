script_location=$(pwd)
LOG=/tmp/roboshop.log
status_check(){
  if [ $? -eq 0 ];then
    echo -e "\e[36m Success\e[0m"
  else
    echo -e "\e[36m Failure\e[0m"
    echo "service got failed for more info refer"- ${LOG}
    exit
  fi
}

print_head(){
  echo -e "\e[1m $1\e[0m"
}

APP-PREREQ(){
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
      curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${LOG}
      status_check

    print_head "Clean Up"
      rm -rf /app/* &>>${LOG}
      status_check

    print_head "Changr dir"
      cd /app &>>${LOG}
      status_check

    print_head "UNZIP"
      unzip /tmp/${component}.zip &>>${LOG}
      status_check
}

   Systemd(){
     print_head "Loading external file"
          cp ${script_location}/files/${component}-roboshop.conf /etc/systemd/system/${component}.service
         status_check

      print_head "daemonon Load"
        systemctl daemon-reload &>>${LOG}
        status_check

        print_head "enable ${component}"
        systemctl enable ${component} &>>${LOG}
        status_check

        print_head "start ${component}"
        systemctl start ${component} &>>${LOG}
        status_check

   }

   Load_schema(){
     if [ ${schema_load} == "true" ];then

       if [ ${schema_type} == "mongo" ];then

           print_head "creating Repo"
             curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG}
             status_check

           print_head "schema Load"
           mongo --host mongodb.ramdevops35.online </app/schema/${component}.js &>>${LOG}
           status_check

           print_head "Install mongodb"
             labauto mongodb-client &>>${LOG}
             status_check
         fi
         if [ ${schema_type} == "mysql" ];then
           print_head "Install Mysql"
            labauto mysql-client
            status_check

          print_head "Install Mysql"
           mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -p ${root_mysql_password} < /app/schema/shipping.sql
           status_check
          fi
     fi
   }


Node(){

  print_head "Install NodeJS"
  yum install nodejs -y &>>${LOG}
  status_check


  print_head "INSTALL NPM"
  npm install &>>${LOG}
  status_check

  APP-PREREQ

  Systemd

Load_schema
}

Maven(){
  print_head "Install Maven"
  yum install maven -y &>>${LOG}
  status_check

  APP_PREREQ

print_head "cleanup"
  mvn clean package &>>${LOG}
   status_check

  print_head "Loading Dependencies"
   mv target/${component}-1.0.jar ${component}.jar &>>${LOG}
  status_check

  Systemd

  Load_schema


}