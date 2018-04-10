#!/usr/bin/env bash

#https://nodejs.org/en/download/package-manager/

#nodejs install script . ohyoungjooung@gmail.com

NPM=`which npm`
CUR=`which curl`

already_ok(){
  if [[ $NPM ]]
  then
    echo "`$NPM -v` already installed"
    exit 0
  fi
}
  

check_man(){
 if [[ `which yum` ]]
 then
  CM="yum"
 elif [[ `which apt-get` ]]
 then
  CM="apt-get"
 fi
}

installed_ok(){
  if [[ $? == "0" ]]
  then 
     echo "Install $1 ok"
  else
     echo "Install $i fail"
     exit 1
  fi
} 

success_ok(){
  NPMA=`which npm`
  if [[ $NPMA ]]
  then
    echo "nodes js `$NPMA -v` install success,congratulations"
  else
    echo "nodes js install failed"
  fi
}

     

install_node(){
  if [[ ! $CUR ]]
  then
     echo "Curl is not install install, gonna install it"
     $CM -y install curl
  elif [[ $CM == "yum" ]]
  then
     $CUR --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash -
     #$CUR --silent --location https://rpm.nodesource.com/setup_9.x | sudo bash -
     installed_ok repo_setup
   echo "Gonna install nodejs"
    sleep 1
    sudo yum -y install nodejs
     installed_ok nodejs
    echo "Gonna install npm build tools"
    sudo yum -y install gcc-c++ make
     installed_ok "gcc-c++-make"
   elif [[ $CM == "apt-get" ]]
   then
        $CUR https://deb.nodesource.com/setup_8.x | sudo -E bash -
        #$CUR https://deb.nodesource.com/setup_9.x | sudo -E bash -
        installed_ok repo_setup
        echo "Gonna install nodejs"
       sleep 1
    sudo $CM -y install nodejs
        installed_ok nodejs
    echo "Gonna install npm build tools"
    sudo apt-get install -y build-essential
        installed_ok "build-essential"
    fi
}

already_ok
check_man
install_node
success_ok
