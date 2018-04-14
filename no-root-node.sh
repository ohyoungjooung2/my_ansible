#!/usr/bin/env bash
#Current Date: 


#Binary 
#https://nodejs.org/dist/v8.11.1/node-v8.11.1-linux-x64.tar.xz

#Source code
#https://nodejs.org/dist/v8.11.1/node-v8.11.1.tar.gz
#nodejs non root install script . ohyoungjooung@gmail.com

#Using binary,,,

NPM=`which npm`
CUR=`which curl`
NODE_ROOT="node-v8.11.1-linux-x64"

check_pre(){
 if [[ `which yum` ]]
 then
   V=$(cat /etc/redhat-release | awk '{ print $1"-"$3"}')
   echo "Seem like yum based distro $V(Centos,Redhat)"
   echo "Installing gcc-c++ make"
   sudo yum -y install gcc-c++ make curl
 elif [[ `which apt-get` ]]
 then
   V=$(lsb_release -d)
   echo "$V Seem like apt-get based distro(Debian,Ubuntu)"
   sudo apt-get install -y build-essential curl

 fi
}


install_ok(){
  if [[ $? == "0" ]]
  then 
     echo "Install $1 ok"
  else
     echo "Install $i fail"
     exit 1
  fi
} 

install_bin(){
  echo "Downing"
  if [[ ! -d $HOME/node ]]
  then
   mkdir $HOME/node
  fi
 
  cd $HOME/node
  $CUR -o node811-bin.tar.xz https://nodejs.org/dist/v8.11.1/node-v8.11.1-linux-x64.tar.xz
  tar xvJf node811-bin.tar.xz
  install_ok node811
  
 } 

install_npmrc(){
 echo "root = $HOME/node/$NODE_ROOT/lib/node_modules" >> ~/.npmrc
 echo "binroot = $HOME/node/$NODE_ROOT/bin" >> ~/.npmrc
}


install_path(){
  echo "export PATH=$HOME/node/$NODE_ROOT/bin:$PATH" >> ~/.bash_profile
  exec bash
}

check_npmrc(){
  if [[ ! -e $HOME/.npmrc ]]
  then
     install_npmrc
     install_ok .npmrc
  fi
}

check_pre
install_bin
check_npmrc
install_path

