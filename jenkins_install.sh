#!/usr/bin/env bash
java_check(){
  JAVA_CHECK=`which java`
  if [[ $JAVA_CHECK ]]
  then
     echo "java installed"
  else
     echo "You must install java to run jenkins"
     echo "Do you want to install oracle java?"
     read ANSWER
     if [[ $ANSWER=="y" ]]
     then
       sudo bash download_java.sh 8
     fi
  fi
}

install_jenkins(){
  if [[ -e /usr/bin/apt ]]
  then
   sudo wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
   sudo su -c "echo 'deb https://pkg.jenkins.io/debian-stable binary/' >> /etc/apt/sources.list"
   sudo apt-get update -y
   sudo apt-get install jenkins -y
  elif [[ -e /bin/yum ]]
  then
   sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
   sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
   sudo yum -y install jenkins
   sudo systemctl enable jenkins.service
   sudo systemctl start jenkins.service

  fi
}

check_jenkins(){
  ps -ef | grep -i jenkins
  sudo systemctl status jenkins.service
}

java_check
install_jenkins
check_jenkins
