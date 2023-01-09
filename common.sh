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

APP_PREREQ() {

  print_head "Add Application User"
  id roboshop &>>${LOG}
  if [ $? -ne 0 ]; then
    useradd roboshop &>>${LOG}
  fi
  status_check
  }

  mkdir -p /app &>>${LOG}

