#!/usr/bin/env bash
JAVA_VERSION="9.0.4"
TARGET_DIR="/usr/local"

path_check(){
  CHECK=$(echo $PATH | grep -i $JAVA_VERSION/bin)
  if [[ $CHECK != "" ]]
  then
     echo "java $JAVA_VERSION ALREADY INSTALLED"
  else
     echo "PATH=/usr/local/jdk-$JAVA_VERSION/bin:$PATH" >> /etc/profile
     source /etc/profile
  fi
}

download_oracle(){
 wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/9.0.4+11/c2514751926b4512b076cc82f959763f/jdk-9.0.4_linux-x64_bin.tar.gz -O $TARGET_DIR/java-9.tar.gz
 cd $TARGET_DIR;
 tar xvzf java-9.tar.gz
} 


if [[ -x $TARGET_DIR/jdk-$JAVA_VERSION/bin/java ]]
then
 echo "java already installed"
 source /etc/profile
 path_check
else
 download_oracle
 path_check
fi
