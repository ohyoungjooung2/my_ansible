#!/usr/bin/env bash
JAVA_VERSION="10.0.1"
TARGET_DIR="/usr/local"
DOWN_URL="http://download.oracle.com/otn-pub/java/jdk/10.0.1+10/fb4372174a714e6b8c52526dc134031e/jdk-10.0.1_linux-x64_bin.tar.gz"
download_oracle_java(){
 wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" $DOWN_URL -O $TARGET_DIR/java-$JAVA_VERSION.tar.gz
 cd $TARGET_DIR;
 tar xzf java-$JAVA_VERSION.tar.gz
} 


if [[ -x $TARGET_DIR/jdk-$JAVA_VERSION/bin/java ]]
then
 echo "java already installed"
 exit 0
else
 download_oracle_java
fi

#path_check(){
#  CHECK=$(echo $PATH | grep -i $JAVA_VERSION/bin)
#  if [[ $CHECK != "" ]]
#  then
#     echo "java $JAVA_VERSION path already done"
#  else
#     echo "PATH=/usr/local/jdk-$JAVA_VERSION/bin:$PATH" >> /etc/profile
#     source /etc/profile
#  fi
#}
