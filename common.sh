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