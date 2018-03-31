MY XUBUNTU WORKSTATION 

oyj@Workstation-oyj-X555QG ~/vagrant_ansi$lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 16.04.4 LTS
Release:	16.04
Codename:	xenial
oyj@Workstation-oyj-X555QG ~/vagrant_ansi$

#Virtualbox version. There are when virtualbox and vagrant do not meet. But, my environment is ok.
Version 5.2.4 r119785 (Qt5.6.1)


#Like belows, if we execute ansible outside .ansible directory then, ansible looks for ansible.cfg in /etc/ansible/ directory 
first, but if you execute ansible in .ansible directory, it looks for ansible.cfg in ~/.ansible directory first.
oyj@Workstation-oyj-X555QG ~$ansible --version
ansible 2.5.0
  config file = /etc/ansible/ansible.cfg
  configured module search path = [u'/home/oyj/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python2.7/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 2.7.12 (default, Dec  4 2017, 14:50:18) [GCC 5.4.0 20160609]
oyj@Workstation-oyj-X555QG ~$cd .ansible/
oyj@Workstation-oyj-X555QG ~/.ansible$ansible --version
ansible 2.5.0
  config file = /home/oyj/.ansible/ansible.cfg
  configured module search path = [u'/home/oyj/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python2.7/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 2.7.12 (default, Dec  4 2017, 14:50:18) [GCC 5.4.0 20160609]


Not to be complicated, we'd better remove /etc/ansible/ansible.cfg and use ~/.ansible/ansible.cfg as a default.


oyj@Workstation-oyj-X555QG ~/.ansible$sudo rm -f /etc/ansible/ansible.cfg
oyj@Workstation-oyj-X555QG ~/.ansible$echo "export ANSIBLE_CONFIG=~/.ansible/ansible.cfg" >> ~/.bashrc



#As a Linux admin taste, I do not want to use /etc/ansible/hosts as a ansible hosts main and deprecation warning message.
#With 'ansible -i file' option, we can designate wanted hosts file, such as 'ansible -i production or ansible -i development'. 

oyj@Workstation-oyj-X555QG ~/.ansible$vi /home/oyj/.ansible/ansible.cfg 


# config file for ansible -- https://ansible.com/
# ===============================================

# nearly all parameters can be overridden in ansible-playbook
# or with command line flags. ansible will read ANSIBLE_CONFIG,
# ansible.cfg in the current working directory, .ansible.cfg in
# the home directory or /etc/ansible/ansible.cfg, whichever it
# finds first

[defaults]

# some basic default values...

inventory      = ~/.ansible/hosts
remote_port    = 22
deprecation_warnings = False


[inventory]

[privilege_escalation]

[paramiko_connection]


[ssh_connection]


[persistent_connection]


[accelerate]

[selinux]

[colors]


[diff]


oyj@Workstation-oyj-X555QG ~/Downloads$sudo dpkg -i vagrant_2.0.3_x86_64.deb 


oyj@Workstation-oyj-X555QG ~$mkdir vagrant_ansi
oyj@Workstation-oyj-X555QG ~$cd vagrant_ansi/
oyj@Workstation-oyj-X555QG ~/vagrant_ansi$vi Vagrantfile
oyj@Workstation-oyj-X555QG ~/vagrant_ansi$vi Vagrantfile 

 -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

   config.vm.define "ct7vag" do |ct7vag|
   ct7vag.vm.box = "centos/7"
   ct7vag.vm.network "private_network", ip:"10.0.0.5"
   ct7vag.vm.host_name = "ct7vag"
     ct7vag.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "256"]
     end
   end


   config.vm.define "ct6vag" do |ct6vag|
   ct6vag.vm.box = "centos/6"
   ct6vag.vm.network "private_network", ip:"10.0.0.6"
   ct6vag.vm.host_name = "ct6vag"
     ct6vag.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "256"]
     end
   end

   config.vm.define "u16vag" do |u16vag|
   u16vag.vm.box = "ubuntu/xenial64"
   u16vag.vm.network "private_network", ip:"10.0.0.7"
   u16vag.vm.host_name = "u16vag"
     u16vag.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "256"]
     end
   end

end



oyj@Workstation-oyj-X555QG ~/vagrant_ansi$vagrant up

oyj@Workstation-oyj-X555QG ~/vagrant_ansi$vagrant status
Current machine states:

ct7vag                    running (virtualbox)
ct6vag                    running (virtualbox)
u16vag                    running (virtualbox)

This environment represents multiple VMs. The VMs are all listed
above with their current state. For more information about a specific
VM, run `vagrant status NAME`.




root@workstation-oyj-X555QG:/etc/apt/sources.list.d# vi ansible.list 


deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main


root@workstation-oyj-X555QG:/etc/apt/sources.list.d# apt-get update



root@oyj-X555QG:/etc/apt/sources.list.d# apt-get -y install ansible

Other resources
http://docs.ansible.com/ansible/latest/intro_installation.html#basics-what-will-be-installed


root@Workstation-oyj-X555QG:~# ansible --version
ansible 2.5.0
  config file = /etc/ansible/ansible.cfg
  configured module search path = [u'/root/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python2.7/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 2.7.12 (default, Dec  4 2017, 14:50:18) [GCC 5.4.0 20160609]

---Domain configuration---
oyj@Workstation-oyj-X555QG ~/vagrant_ansi$sudo vi /etc/hosts

127.0.0.1       localhost myblog.oyj

10.0.0.5        ct7vag
10.0.0.7        u16vag
10.0.0.6        ct6vag



#SSH configuration


*ssh config
 ssh-key generations.
oyj@Workstation-oyj-X555QG ~$ssh-keygen -t rsa
Generating public/private rsa key pair.
Enter file in which to save the key (/home/oyj/.ssh/id_rsa): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/oyj/.ssh/id_rsa.
Your public key has been saved in /home/oyj/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:Ycwve+PnzW5MqsrHw3tGqQQwFoJqr3Mt7IO9D9ph9GE oyj@Workstation-oyj-X555QG
The key's randomart image is:
+---[RSA 2048]----+
|   .. ..         |
|  .  .+o         |
| .   . o=        |
|..     ..o       |
|. .. E  S..  .   |
|  ..o .  o. o .  |
|  =+..  .+oo +   |
| ++*o. . o*.=oo  |
| .++=.  oo+O.o+  |
+----[SHA256]-----+
oyj@Workstation-oyj-X555QG ~$cd .ssh/

oyj@Workstation-oyj-X555QG ~$ssh-agent bash
oyj@Workstation-oyj-X555QG ~$ssh-add ~/.ssh/id_rsa
Enter passphrase for /home/oyj/.ssh/id_rsa: 
Identity added: /home/oyj/.ssh/id_rsa (/home/oyj/.ssh/id_rsa)
oyj@Workstation-oyj-X555QG ~$

*ssh key add on each hosts
oyj@Workstation-oyj-X555QG ~/Desktop$cat ~/.ssh/id_rsa.pub 
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDKvWBXKkvujm0rbEsVVJndbrlcqtwJZ4tKdFmFeIjvoGChfuALI3z8xTz2cZEZRdxG5IL03opUbfsRx/Kwdpbqz1/ok8UAEFKIEGW48+8y+d1+Ob2bUatd6Pkvidg/w4EGjSZohcCvo+xF3h/97ig+Co8c3gIwKK8TzMg6CueXH1IgMASxrnC1PZfPF/340Zdvw/I2hR7QHTT5mJYtGsuYQVNYafGU1/UJR8/nXqUj0Nb+OxIQhd4XmsUcccvJpuIrw1o8YnX4USQ92d/FdZxZ5Wf8M50k4FBXc83e/QyoicHk6+VAO+cNSgHPLJeF90ZGJZrrUl2UgGLznwbU7TJv oyj@Workstation-oyj-X555QG


oyj@Workstation-oyj-X555QG ~/vagrant_ansi$vagrant ssh ct7vag
Last login: Thu Mar 29 10:02:43 2018 from 10.0.2.2
[vagrant@ct7vag ~]$ vi ~/.ssh/authorized_keys 
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9+0tqBR3GhZ8AbLi/Wh4BWoULfbY0k2A4ilqiyD6X5AiUs3umQsftE8u2jrCnU9WfjCx37QP8YVBM16kwOJOIreZbM5XRdOYfNjMmiKIi/wMVIC6tcWx1VKrG6X5gkBfTKQFmHEbcTOeCmsYJfkzXa2kSq9mwVDG23NUz66BggvJvXQh5gtO38vnVDag4+zy52NQ4m8OpC0zwiSkRz4peE2AeJ1icIgREh/ufdmfIIuEbvBWj37PzgKaQZB4xl73UiHc9WLw0Fs2noA5uBuiiFKr64y6OLde72/5zwjFySGmXSNwhZwok1jGNz6cGiT7kF/Z1zLLUxmj6xOhLmY31 vagrant
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDKvWBXKkvujm0rbEsVVJndbrlcqtwJZ4tKdFmFeIjvoGChfuALI3z8xTz2cZEZRdxG5IL03opUbfsRx/Kwdpbqz1/ok8UAEFKIEGW48+8y+d1+Ob2bUatd6Pkvidg/w4EGjSZohcCvo+xF3h/97ig+Co8c3gIwKK8TzMg6CueXH1IgMASxrnC1PZfPF/340Zdvw/I2hR7QHTT5mJYtGsuYQVNYafGU1/UJR8/nXqUj0Nb+OxIQhd4XmsUcccvJpuIrw1o8YnX4USQ92d/FdZxZ5Wf8M50k4FBXc83e/QyoicHk6+VAO+cNSgHPLJeF90ZGJZrrUl2UgGLznwbU7TJv oyj@Workstation-oyj-X555QG

oyj@Workstation-oyj-X555QG ~/vagrant_ansi$vagrant ssh ct6vag
[vagrant@ct6vag ~]$ vi ~/.ssh/authorized_keys 
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9+0tqBR3GhZ8AbLi/Wh4BWoULfbY0k2A4ilqiyD6X5AiUs3umQsftE8u2jrCnU9WfjCx37QP8YVBM16kwOJOIreZbM5XRdOYfNjMmiKIi/wMVIC6tcWx1VKrG6X5gkBfTKQFmHEbcTOeCmsYJfkzXa2kSq9mwVDG23NUz66BggvJvXQh5gtO38vnVDag4+zy52NQ4m8OpC0zwiSkRz4peE2AeJ1icIgREh/ufdmfIIuEbvBWj37PzgKaQZB4xl73UiHc9WLw0Fs2noA5uBuiiFKr64y6OLde72/5zwjFySGmXSNwhZwok1jGNz6cGiT7kF/Z1zLLUxmj6xOhLmY31 vagrant



oyj@Workstation-oyj-X555QG ~/vagrant_ansi$vagrant ssh u16vag
Welcome to Ubuntu 16.04.4 LTS (GNU/Linux 4.4.0-116-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  Get cloud support with Ubuntu Advantage Cloud Guest:
    http://www.ubuntu.com/business/services/cloud

0 packages can be updated.
0 updates are security updates.


vagrant@u16vag:~$ vi ~/.ssh/authorized_keys 
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9+0tqBR3GhZ8AbLi/Wh4BWoULfbY0k2A4ilqiyD6X5AiUs3umQsftE8u2jrCnU9WfjCx37QP8YVBM16kwOJOIreZbM5XRdOYfNjMmiKIi/wMVIC6tcWx1VKrG6X5gkBfTKQFmHEbcTOeCmsYJfkzXa2kSq9mwVDG23NUz66BggvJvXQh5gtO38vnVDag4+zy52NQ4m8OpC0zwiSkRz4peE2AeJ1icIgREh/ufdmfIIuEbvBWj37PzgKaQZB4xl73UiHc9WLw0Fs2noA5uBuiiFKr64y6OLde72/5zwjFySGmXSNwhZwok1jGNz6cGiT7kF/Z1zLLUxmj6xOhLmY31 vagrant
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDKvWBXKkvujm0rbEsVVJndbrlcqtwJZ4tKdFmFeIjvoGChfuALI3z8xTz2cZEZRdxG5IL03opUbfsRx/Kwdpbqz1/ok8UAEFKIEGW48+8y+d1+Ob2bUatd6Pkvidg/w4EGjSZohcCvo+xF3h/97ig+Co8c3gIwKK8TzMg6CueXH1IgMASxrnC1PZfPF/340Zdvw/I2hR7QHTT5mJYtGsuYQVNYafGU1/UJR8/nXqUj0Nb+OxIQhd4XmsUcccvJpuIrw1o8YnX4USQ92d/FdZxZ5Wf8M50k4FBXc83e/QyoicHk6+VAO+cNSgHPLJeF90ZGJZrrUl2UgGLznwbU7TJv oyj@Workstation-oyj-X555QG






--Do not logout til ansible ping check is success--

oyj@Workstation-oyj-X555QG ~/vagrant_ansi$ssh -i ~/.ssh/id_rsa vagrant@ct6vag
[vagrant@ct6vag ~]$ sudo -i
--Change from enforcing to permissive--
[root@ct6vag ~]# vi /etc/sysconfig/selinux 

# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.
#SELINUX=enforcing
SELINUX=permissive
# SELINUXTYPE= can take one of these two values:
#     targeted - Targeted processes are protected,
#     mls - Multi Level Security protection.
SELINUXTYPE=targeted

[root@ct6vag ~]# setenforce 0
[root@ct6vag ~]# setenforce 0
[root@ct6vag ~]# sestatus
SELinux status:                 enabled
SELinuxfs mount:                /selinux
Current mode:                   permissive
Mode from config file:          permissive
Policy version:                 24
Policy from config file:        targeted

[root@ct6vag ~]# vi /etc/ssh/sshd_config 
#Port change 22 to 70
# This is the sshd server system-wide configuration file.  See
# sshd_config(5) for more information.

# This sshd was compiled with PATH=/usr/local/bin:/bin:/usr/bin

# The strategy used for options in the default sshd_config shipped with
# OpenSSH is to specify options with their default value where
# possible, but leave them commented.  Uncommented options change a
# default value.

oyj@Workstation-oyj-X555QG ~/vagrant_ansi$sudo vi /etc/ansible/ansible.cfg

[defaults]

# some basic default values...

inventory      = ~/.ansible/hosts
#library        = /usr/share/my_modules/
#module_utils   = /usr/share/my_module_utils/
#remote_tmp     = ~/.ansible/tmp
#local_tmp      = ~/.ansible/tmp
#forks          = 5
#poll_interval  = 15
#sudo_user      = root
#ask_sudo_pass = True
#ask_pass      = True
#transport      = smart
#remote_port    = 22



....




---Now ansible hosts confiuration--
oyj@Workstation-oyj-X555QG ~/vagrant_ansi$vi ~/.ansible/hosts 

[vagdev]
ct7vag
ct6vag
u16vag

[vagdev:vars]
ansible_ssh_user=vagrant
ansible_ssh_private_key_file=~/.ssh/id_rsa




---ansible connection check ---

oyj@Workstation-oyj-X555QG ~/vagrant_ansi$ansible ct7vag -m 'ping'
The authenticity of host '[ct7vag]:22 ([10.0.0.5]:22)' can't be established.
ECDSA key fingerprint is SHA256:KUH8oRaLUOdSl6Lj9Ie3659dwHCqMMLjTIQbnqBSZJI.
Are you sure you want to continue connecting (yes/no)? yes
ct7vag | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}
oyj@Workstation-oyj-X555QG ~/vagrant_ansi$ansible ct6vag -m 'ping'
ct6vag | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}


oyj@Workstation-oyj-X555QG ~/vagrant_ansi$ansible u16vag -m 'ping'
The authenticity of host '[u16vag]:22 ([10.0.0.7]:22)' can't be established.
ECDSA key fingerprint is SHA256:IuN9U5uuBhYJJ+MlVVXSE9S8eZKZUU1P0PzZcW2LXrU.
Are you sure you want to continue connecting (yes/no)? yes
u16vag | FAILED! => {
    "changed": false, 
    "module_stderr": "Shared connection to u16vag closed.\r\n", 
    "module_stdout": "/bin/sh: 1: /usr/bin/python: not found\r\n", 
    "msg": "MODULE FAILURE", 
    "rc": 127
}

---Well, no python is installed on ubuntu 16 vagrant box on default ---

oyj@Workstation-oyj-X555QG ~/vagrant_ansi$ssh -i ~/.ssh/id_rsa vagrant@u16vag -p 70
Welcome to Ubuntu 16.04.4 LTS (GNU/Linux 4.4.0-116-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  Get cloud support with Ubuntu Advantage Cloud Guest:
    http://www.ubuntu.com/business/services/cloud

0 packages can be updated.
0 updates are security updates.



vagrant@u16vag:~$ sudo -i
root@u16vag:~# which python
root@u16vag:~# apt-get -y install python

root@u16vag:~# python --version
Python 2.7.12
root@u16vag:~# exit

oyj@Workstation-oyj-X555QG ~/vagrant_ansi$ansible u16vag -m 'ping'
u16vag | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}


---Now everything seems ok ---
u16vag | SUCCESS | rc=0 >>
u16vag

ct6vag | SUCCESS | rc=0 >>
ct6vag

ct7vag | SUCCESS | rc=0 >>
ct7vag


---Congurations!---


##################################################################3
Goal: Using ansible-galaxy repo. Adjusting ntp time daemon server.

playbook ntp.
I want to change timezone from from UTC to KST.
On some application, each server's time correctness is very critical, so, we need to adjust time exactness before any
deployment of any applications.


##################################################################

With ansible, we can inspect each server's time like below.
oyj@Workstation-oyj-X555QG ~/vagrant_ansi$ansible vagdev -a 'date'
ct6vag | SUCCESS | rc=0 >>
2018. 03. 29. (목) 13:20:03 UTC

u16vag | SUCCESS | rc=0 >>
Thu Mar 29 13:20:03 UTC 2018

ct7vag | SUCCESS | rc=0 >>
Thu Mar 29 13:20:03 UTC 2018

#My timezone is KST and ntp.pool.org is recommending asia ntp pool server.
oyj@Workstation-oyj-X555QG ~$ansible-galaxy install geerlingguy.ntp
- downloading role 'ntp', owned by geerlingguy
- downloading role from https://github.com/geerlingguy/ansible-role-ntp/archive/1.5.3.tar.gz
- extracting geerlingguy.ntp to /home/oyj/.ansible/roles/geerlingguy.ntp
- geerlingguy.ntp (1.5.3) was installed successfully

***
***Timezone to Asia/Seoul***
oyj@Workstation-oyj-X555QG ~/.ansible/roles/geerlingguy.ntp$cat vars/main.yml 
ntp_timezone: Asia/Seoul

oyj@Workstation-oyj-X555QG ~/.ansible/roles/geerlingguy.ntp/defaults$vi ~/.ansible/roles/geerlingguy.ntp/defaults/main.yml 
---
ntp_enabled: true
#Change time zone to Asia/Seoul where I live.
ntp_timezone: Asia/Seoul

#From false to true
ntp_manage_config: true

# NTP server area configuration (leave empty for 'Worldwide').
# See: http://support.ntp.org/bin/view/Servers/NTPPoolServers
ntp_area: '.asia'
ntp_servers:
  - "0{{ ntp_area }}.pool.ntp.org iburst"
  - "1{{ ntp_area }}.pool.ntp.org iburst"
  - "2{{ ntp_area }}.pool.ntp.org iburst"
  - "3{{ ntp_area }}.pool.ntp.org iburst"

ntp_restrict:
  - "127.0.0.1"
  - "::1"

**On ubuntu xenial server, We need to add ntpstat package to check sync status **
oyj@Workstation-oyj-X555QG ~/.ansible/roles/geerlingguy.ntp/tasks$vi main.yml 

#Added part
- name: Ensure ntpstat package is installed (Debian).
  package:
    name: ntpstat
    state: present
  when: ansible_os_family == "Debian"
#CentOS7 use chronyd as default time daemon. Anyhow when you want to use ntpd, you have to disable chronyd.
- name: Ensure chronyd stopd when Centos7 is ths os
  service:
    name: chronyd
    state: stopped
    enabled: no
  when: ansible_os_family == 'RedHat' and ansible_distribution_version.split('.')[0] == '7'

- name: Ensure libselinux-python is installed
  package:
    name: libselinux-python
    state: present
  when: ansible_os_family == 'RedHat'


#all
oyj@Workstation-oyj-X555QG ~/.ansible/roles/geerlingguy.ntp/tasks$ls
clock-rhel-6.yml  main.yml
oyj@Workstation-oyj-X555QG ~/.ansible/roles/geerlingguy.ntp/tasks$cat main.yml 
---
- name: Include OS-specific variables.
  include_vars: "{{ ansible_os_family }}.yml"

- name: Ensure NTP-related packages are installed.
  package:
    name: ntp
    state: present

- name: Ensure tzdata package is installed (Linux).
  package:
    name: tzdata
    state: present
  when: ansible_system == "Linux"

- name: Ensure ntpstat package is installed (Debian).
  package:
    name: ntpstat
    state: present
  when: ansible_os_family == "Debian"

- name: Ensure libselinux-python is installed
  package:
    name: libselinux-python
    state: present
  when: ansible_os_family == 'RedHat'

#CentOS7 use chronyd as default time daemon. Anyhow when you want to use ntpd, you have to disable chronyd.
- name: Ensure chronyd stopd when Centos7 is ths os
  service:
    name: chronyd
    state: stopped
    enabled: no
  when: ansible_os_family == 'RedHat' and ansible_distribution_version.split('.')[0] == '7'

- include: clock-rhel-6.yml
  when: ansible_os_family == 'RedHat' and ansible_distribution_version.split('.')[0] == '6'

- name: Set timezone
  timezone:
    name: "{{ ntp_timezone }}"

- name: Ensure NTP is running and enabled as configured.
  service:
    name: "{{ ntp_daemon }}"
    state: started
    enabled: yes
  when: ntp_enabled

- name: Ensure NTP is stopped and disabled as configured.
  service:
    name: "{{ ntp_daemon }}"
    state: stopped
    enabled: no
  when: not ntp_enabled

- name: Generate ntp.conf file
  template:
    src: ntp.conf.j2
    dest: /etc/ntp.conf
  notify: restart ntp
  when: ntp_manage_config

oyj@Workstation-oyj-X555QG ~/.ansible/roles/geerlingguy.ntp/tasks$cat clock-rhel-6.yml 

---
- name: Check if clock file exists.
  stat: path=/etc/sysconfig/clock
  register: clock_file

- name: Create clock file if it doesn't exist.
  template:
    src: clock.j2
    dest: /etc/sysconfig/clock
  when: clock_file.stat.exists == false





*Create ntp.yml
oyj@Workstation-oyj-X555QG ~/.ansible$ls
cp  ntp.yml  roles  tmp
oyj@Workstation-oyj-X555QG ~/.ansible$vi ntp.yml 

- hosts: vagdev
  roles:
    - geerlingguy.ntp
~                      

##Let't play##

oyj@Workstation-oyj-X555QG ~/.ansible$ansible-playbook ntp.yml -b


oyj@Workstation-oyj-X555QG ~/.ansible$ansible-playbook ntp.yml -b

PLAY [vagdev] *****************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************
ok: [ct7vag]
ok: [u16vag]
ok: [ct6vag]

TASK [geerlingguy.ntp : Include OS-specific variables.] ***********************************************************************************************
ok: [ct7vag]
ok: [ct6vag]
ok: [u16vag]

TASK [geerlingguy.ntp : Ensure NTP-related packages are installed.] ***********************************************************************************
ok: [ct7vag]
ok: [ct6vag]
ok: [u16vag]

TASK [geerlingguy.ntp : Ensure tzdata package is installed (Linux).] **********************************************************************************
ok: [ct6vag]
ok: [ct7vag]
ok: [u16vag]

TASK [geerlingguy.ntp : Ensure ntpstat package is installed (Debian).] ********************************************************************************
skipping: [ct7vag]
skipping: [ct6vag]
changed: [u16vag]

TASK [geerlingguy.ntp : Ensure libselinux-python is installed] ****************************************************************************************
skipping: [u16vag]
ok: [ct7vag]
changed: [ct6vag]

TASK [geerlingguy.ntp : Ensure chronyd stopd when Centos7 is ths os] **********************************************************************************
skipping: [ct6vag]
skipping: [u16vag]
ok: [ct7vag]

TASK [geerlingguy.ntp : Check if clock file exists.] **************************************************************************************************
skipping: [ct7vag]
skipping: [u16vag]
ok: [ct6vag]

TASK [geerlingguy.ntp : Create clock file if it doesn't exist.] ***************************************************************************************
skipping: [ct7vag]
skipping: [ct6vag]
skipping: [u16vag]

TASK [geerlingguy.ntp : Set timezone] *****************************************************************************************************************
ok: [ct6vag]
ok: [u16vag]
ok: [ct7vag]

TASK [geerlingguy.ntp : Ensure NTP is running and enabled as configured.] *****************************************************************************
ok: [u16vag]
ok: [ct7vag]
ok: [ct6vag]

TASK [geerlingguy.ntp : Ensure NTP is stopped and disabled as configured.] ****************************************************************************
skipping: [ct7vag]
skipping: [ct6vag]
skipping: [u16vag]

TASK [geerlingguy.ntp : Generate ntp.conf file] *******************************************************************************************************
changed: [u16vag]
changed: [ct7vag]
changed: [ct6vag]

RUNNING HANDLER [geerlingguy.ntp : restart ntp] *******************************************************************************************************
changed: [u16vag]
changed: [ct7vag]
changed: [ct6vag]

PLAY RECAP ********************************************************************************************************************************************
ct6vag                     : ok=10   changed=3    unreachable=0    failed=0   
ct7vag                     : ok=10   changed=2    unreachable=0    failed=0   
u16vag                     : ok=9    changed=3    unreachable=0    failed=0   

oyj@Workstation-oyj-X555QG ~/.ansible$ansible vagdev -a 'ntpstat' 
u16vag | SUCCESS | rc=0 >>
synchronised to NTP server (103.47.76.177) at stratum 3 
   time correct to within 573 ms
   polling server every 64 s

ct6vag | SUCCESS | rc=0 >>
synchronised to NTP server (211.233.84.186) at stratum 3 
   time correct to within 1057 ms
   polling server every 64 s

ct7vag | SUCCESS | rc=0 >>
synchronised to NTP server (120.25.108.11) at stratum 3 
   time correct to within 488 ms
   polling server every 64 s

oyj@Workstation-oyj-X555QG ~/.ansible$ansible vagdev -a 'date' 
u16vag | SUCCESS | rc=0 >>
Thu Mar 29 23:52:07 KST 2018

ct6vag | SUCCESS | rc=0 >>
2018. 03. 29. (목) 23:52:07 KST

ct7vag | SUCCESS | rc=0 >>
Thu Mar 29 23:52:07 KST 2018



Congratulations.!


#######################################################################################
Goal:Java jdk 9.0.4 installation from download.oracle.com.

Sometimes it is necessary to install from source or website. Ansible does not provide some options that can 
be done using bash shell script. 

######################################################################################

oyj@Workstation-oyj-X555QG ~/.ansible$vi java.yml 
---
- name: Java install
  hosts: vagdev
  vars:
     java_version: 9.0.4
     java_home: /usr/local/jdk-9.0.4


  tasks:
     - name: Ensure wget package installed
       package:
         name: wget
         state: present

     - name: Ensure java.sh into /etc/profile.d
       template: src=templates/java.sh.j2 dest=/etc/profile.d/java.sh
          mode=0644

     #- name: Download java
     - script: ./download_java.sh

     - debug:
         msg: "System {{ inventory_hostname }} installed  jdk {{ java_version }} in {{ java_home }}"


oyj@Workstation-oyj-X555QG ~/.ansible$vi download_java.sh 

                                   
#!/usr/bin/env bash
JAVA_VERSION="9.0.4"
TARGET_DIR="/usr/local"

download_oracle_java(){
 wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/9.0.4+11/c2514751926b4512b076cc82f959763f/jdk-9.0.4_linux-x64_bin.tar.gz -O $TARGET_DIR/java-9.tar.gz
 cd $TARGET_DIR;
 tar xzf java-9.tar.gz
}


if [[ -x $TARGET_DIR/jdk-$JAVA_VERSION/bin/java ]]
then
 echo "java already installed"
 exit 0
else
 download_oracle_java
fi



Let's playbook test.
oyj@Workstation-oyj-X555QG ~/.ansible$ansible-playbook java.yml -b
oyj@Workstation-oyj-X555QG ~/.ansible$ansible-playbook java.yml -b

PLAY [Java install] ****************************************************************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************************************************************
ok: [ct7vag]
ok: [u16vag]
ok: [ct6vag]

TASK [Ensure wget package installed] ***********************************************************************************************************************************
ok: [ct6vag]
ok: [u16vag]
ok: [ct7vag]

TASK [Ensure java.sh into /etc/profile.d] ******************************************************************************************************************************
ok: [u16vag]
ok: [ct7vag]
ok: [ct6vag]

TASK [script] **********************************************************************************************************************************************************
changed: [ct7vag]
changed: [ct6vag]
changed: [u16vag]

TASK [debug] ***********************************************************************************************************************************************************
ok: [ct6vag] => {
    "msg": "System ct6vag installed  jdk 9.0.4 in /usr/local/jdk-9.0.4"
}
ok: [ct7vag] => {
    "msg": "System ct7vag installed  jdk 9.0.4 in /usr/local/jdk-9.0.4"
}
ok: [u16vag] => {
    "msg": "System u16vag installed  jdk 9.0.4 in /usr/local/jdk-9.0.4"
}

PLAY RECAP *************************************************************************************************************************************************************
ct6vag                     : ok=5    changed=1    unreachable=0    failed=0   
ct7vag                     : ok=5    changed=1    unreachable=0    failed=0   
u16vag                     : ok=5    changed=1    unreachable=0    failed=0   


oyj@Workstation-oyj-X555QG ~/.ansible$ansible vagdev -a '/usr/local/jdk-9.0.4/bin/java -version' 
u16vag | SUCCESS | rc=0 >>
java version "9.0.4"
Java(TM) SE Runtime Environment (build 9.0.4+11)
Java HotSpot(TM) 64-Bit Server VM (build 9.0.4+11, mixed mode)

ct6vag | SUCCESS | rc=0 >>
java version "9.0.4"
Java(TM) SE Runtime Environment (build 9.0.4+11)
Java HotSpot(TM) 64-Bit Server VM (build 9.0.4+11, mixed mode)

ct7vag | SUCCESS | rc=0 >>
java version "9.0.4"
Java(TM) SE Runtime Environment (build 9.0.4+11)
Java HotSpot(TM) 64-Bit Server VM (build 9.0.4+11, mixed mode)

Well, it seems very OK!. And I do not want to use java on ct6vag,then just want to remove without login.



##################################################################################################################
Dependency: java version > 8
Goal: Installation of tomcat servlet engine on ct7vag
      Firewalld systemd service is not enabled on vagrant box centos/7. Enable 
##################################################################################################################
oyj@Workstation-oyj-X555QG ~/.ansible$vi hosts


[vagdev]
ct7vag
ct6vag
u16vag

[app]
ct7vag


[vagdev:vars]
ansible_ssh_user=vagrant
ansible_ssh_private_key_file=~/.ssh/id_rsa

oyj@Workstation-oyj-X555QG ~/.ansible$ansible app -m 'ping'
ct7vag | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}
oyj@Workstation-oyj-X555QG ~/.ansible$


oyj@Workstation-oyj-X555QG ~/.ansible$vi tomcat.yml 

---
- name: tomcat install stable
  hosts: app
  vars:
     tomcat_version: 8.5.29
     target_dir: /usr/local
     mirror_host: mirror.navercorp.com
     java_home: /usr/local/jdk-9.0.4
     tomcat_home: /usr/local/apache-tomcat-8.5.29
     tomcat_http_port: 8080
     ssh_port: 70

  tasks:
     - name: Download tomcat tomcat_version
       get_url:
          url: "http://{{ mirror_host }}/apache/tomcat/tomcat-8/v8.5.29/bin/apache-tomcat-8.5.29.tar.gz"
          dest: "{{ target_dir }}"
          checksum: sha1:fdc2ac85282af82a494e352c35e33dcfe1dbab6b
       register: get_tomcat
     

     - debug:
         msg: "System {{ inventory_hostname }} download  tomcat  {{ tomcat_version }} on server"
       when: get_tomcat|changed


     - name: "Untar apache-tomcat-{{ tomcat_version }}"
       unarchive :
         src: "{{ target_dir}}/apache-tomcat-{{ tomcat_version }}.tar.gz"
         dest: "{{ target_dir }}"
         remote_src: yes
          

     - debug:
         msg: "System {{ inventory_hostname }} untar tomcat {{ tomcat_version }}"



     - name: "Add tomcat group"
       group:
         name: tomcat
         state: present
         gid: 321

    
     - name: "Add tomcat user"
       user:
           name: tomcat
           shell: /bin/false
           group: tomcat
           uid:   123

     - name: "Add JAVA_HOME TO /etc/profile.d/"
       template: src=templates/java.sh.j2 dest=/etc/profile.d/java.sh
         mode=0644


     - debug:
         msg: "Add java_home to /etc/profile" 


     - shell: |
         chgrp -R tomcat "{{ target_dir }}/apache-tomcat-{{ tomcat_version }}"
         chmod -R g+r  "{{ target_dir }}/apache-tomcat-{{ tomcat_version }}/conf"
         chmod  g+x  "{{ target_dir }}/apache-tomcat-{{ tomcat_version }}/conf"
         chown -R tomcat "{{ target_dir }}/apache-tomcat-{{ tomcat_version }}/webapps"
         chown -R tomcat "{{ target_dir }}/apache-tomcat-{{ tomcat_version }}/work"
         chown -R tomcat "{{ target_dir }}/apache-tomcat-{{ tomcat_version }}/temp"
         chown -R tomcat "{{ target_dir }}/apache-tomcat-{{ tomcat_version }}/logs"


     - debug:
         msg: "Ownership set {{ target_dir }}/apache-tomcat-{{ tomcat_version }}" 


     - name: "Tomcat {{ tomcat_version }} systemd service add"
       template: src=templates/tomcat_service.j2 dest=/etc/systemd/system/tomcat.service
         mode=0755

  
     - debug:
         msg: "Tomcat {{ tomcat_version }} add to systemd service" 


     - shell: |
         systemctl daemon-reload
         systemctl enable tomcat
         systemctl start tomcat
         #Firewall8080 open
         #firewall-cmd --permanent --add-port=8080/tcp 
         #firewall-cmd --reload

     - debug:
         msg: "Tomcat {{ tomcat_version }} add to systemd service start" 

     - include: firewalled_tomcat.yml
       when: ansible_os_family == 'RedHat' and ansible_distribution_version.split('.')[0] == '7'
     
     - debug:
         msg: "For Centos7 only,Enable firewalld service and open Tomcat {{ tomcat_http_port }} and {{ ssh_port }}  firewalld open" 



oyj@Workstation-oyj-X555QG ~/.ansible$vi firewalled_tomcat.yml 

---
- name: Run firewalld daemon and enable when not enabled.
  systemd:
    name: firewalld
    state: started
    enabled: true

- shell: |
       firewall-cmd --permanent --add-port={{ tomcat_http_port }}/tcp
       firewall-cmd --permanent --add-port={{ ssh_port }}/tcp
       firewall-cmd --reload
~                                                 

oyj@Workstation-oyj-X555QG ~/.ansible$cat templates/java.sh.j2 
export JAVA_HOME=/usr/local/{{ java_home }}
export PATH={{ java_home }}/bin:$PATH
oyj@Workstation-oyj-X555QG ~/.ansible$


Testing and confirm
oyj@Workstation-oyj-X555QG ~/.ansible$ansible-playbook tomcat.yml -b

PLAY [tomcat install stable] ********************************************************************************************************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************************************************************************************************************
ok: [ct7vag]

TASK [Download tomcat tomcat_version] ***********************************************************************************************************************************************************************************
ok: [ct7vag]

TASK [debug] ************************************************************************************************************************************************************************************************************
skipping: [ct7vag]

TASK [Untar apache-tomcat-8.5.29] ***************************************************************************************************************************************************************************************
changed: [ct7vag]

TASK [debug] ************************************************************************************************************************************************************************************************************
ok: [ct7vag] => {
    "msg": "System ct7vag untar tomcat 8.5.29"
}

TASK [Add tomcat group] *************************************************************************************************************************************************************************************************
ok: [ct7vag]

TASK [Add tomcat user] **************************************************************************************************************************************************************************************************
ok: [ct7vag]

TASK [Add JAVA_HOME TO /etc/profile.d/] *********************************************************************************************************************************************************************************
changed: [ct7vag]

TASK [debug] ************************************************************************************************************************************************************************************************************
ok: [ct7vag] => {
    "msg": "Add java_home to /etc/profile"
}

TASK [shell] ************************************************************************************************************************************************************************************************************
 [WARNING]: Consider using the file module with group rather than running chgrp.  If you need to use command because file is insufficient you can add warn=False to this command task or set command_warnings=False in
ansible.cfg to get rid of this message.

changed: [ct7vag]

TASK [debug] ************************************************************************************************************************************************************************************************************
ok: [ct7vag] => {
    "msg": "Ownership set /usr/local/apache-tomcat-8.5.29"
}

TASK [Tomcat 8.5.29 systemd service add] ********************************************************************************************************************************************************************************
ok: [ct7vag]

TASK [debug] ************************************************************************************************************************************************************************************************************
ok: [ct7vag] => {
    "msg": "Tomcat 8.5.29 add to systemd service"
}

TASK [shell] ************************************************************************************************************************************************************************************************************
changed: [ct7vag]

TASK [debug] ************************************************************************************************************************************************************************************************************
ok: [ct7vag] => {
    "msg": "Tomcat 8.5.29 add to systemd service start"
}

TASK [Run firewalld daemon and enable when not enabled.] ****************************************************************************************************************************************************************
ok: [ct7vag]

TASK [shell] ************************************************************************************************************************************************************************************************************
changed: [ct7vag]

TASK [debug] ************************************************************************************************************************************************************************************************************
ok: [ct7vag] => {
    "msg": "For Centos7 only,Enable firewalld service and open Tomcat 8080 and 70  firewalld open"
}

PLAY RECAP **************************************************************************************************************************************************************************************************************
ct7vag                     : ok=17   changed=5    unreachable=0    failed=0   



*****************************************************************************************************
Conclusion: I created tomcat.yml,firewalld_tomcat.yml and java.sh.j2. 
            It is working perfect, but tomcat.yml line is too long to manage and see.
            It is necessay to use role on this tomcat playbook.

*****************************************************************************************************


####################################################################################################

Goal: Create java,tomcat role. And then create java_tomcat.yml palybook.
                                                                                                                                                                                                                                                                                                                                                                                                 
1. Create java role.
oyj@Workstation-oyj-X555QG ~/.ansible/roles$ls
example  geerlingguy.ntp
oyj@Workstation-oyj-X555QG ~/.ansible/roles$mkdir oyj.java
oyj@Workstation-oyj-X555QG ~/.ansible/roles$cd oyj.java/
oyj@Workstation-oyj-X555QG ~/.ansible/roles/oyj.java$ls
oyj@Workstation-oyj-X555QG ~/.ansible/roles/oyj.java$mkdir meta/
oyj@Workstation-oyj-X555QG ~/.ansible/roles/oyj.java$mkdir tasks
oyj@Workstation-oyj-X555QG ~/.ansible/roles/oyj.java$mkdir vars
oyj@Workstation-oyj-X555QG ~/.ansible/roles/oyj.java$vi meta/main.yml
---
dependencies: []

oyj@Workstation-oyj-X555QG ~/.ansible/roles/oyj.java$vi tasks/main.yml
 ---
- name: Ensure wget package installed
  package:
       name: wget
       state: present

- name: Ensure java.sh into /etc/profile.d
  template: src=templates/java.sh.j2 dest=/etc/profile.d/java.sh
          mode=0644
         
#- name: Download java
- script: ./download_java.sh

- debug:
        msg: "System {{ inventory_hostname }} installed  jdk {{ java_version }} in {{ java_home }}"

   
                                         
oyj@Workstation-oyj-X555QG ~/.ansible/roles/oyj.java$cp ~/.ansible/download_java.sh tasks/
oyj@Workstation-oyj-X555QG ~/.ansible/roles/oyj.java$cat tasks/download_java.sh 
#!/usr/bin/env bash
JAVA_VERSION="9.0.4"
TARGET_DIR="/usr/local"

download_oracle_java(){
 wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/9.0.4+11/c2514751926b4512b076cc82f959763f/jdk-9.0.4_linux-x64_bin.tar.gz -O $TARGET_DIR/java-9.tar.gz
 cd $TARGET_DIR;
 tar xzf java-9.tar.gz
} 


if [[ -x $TARGET_DIR/jdk-$JAVA_VERSION/bin/java ]]
then
 echo "java already installed"
 exit 0
else
 download_oracle_java
fi


oyj@Workstation-oyj-X555QG ~/.ansible/roles/oyj.java$vi vars/main.yml
---
java_version: 9.0.4
java_home: /usr/local/jdk-9.0.4



oyj@Workstation-oyj-X555QG ~/.ansible/roles/oyj.java$cp ~/.ansible/templates/java.sh.j2 templates/
oyj@Workstation-oyj-X555QG ~/.ansible/roles/oyj.java$cat templates/java.sh.j2 
export JAVA_HOME=/usr/local/{{ java_home }}
export PATH={{ java_home }}/bin:$PATH



oyj@Workstation-oyj-X555QG ~/.ansible$vi java_role.yml 
- hosts: app
  roles:
    - oyj.java
~                                                                                                                             
~                           

To test java role, remove java files and directories.
oyj@Workstation-oyj-X555QG ~/vagrant_ansi$vagrant ssh ct7vag
Last login: Fri Mar 30 23:30:15 2018 from 10.0.0.1
[vagrant@ct7vag ~]$ sudo -i
[root@ct7vag ~]# which java
/usr/local/jdk-9.0.4/bin/java
[root@ct7vag ~]# rm -rf /usr/local/jdk-9.0.4/
[root@ct7vag ~]# rm -f /etc/profile.d/java.sh 
[root@ct7vag ~]# which java
/usr/bin/which: no java in (/usr/local/jdk-9.0.4/bin:/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin)
[root@ct7vag ~]# exit
logout
[vagrant@ct7vag ~]$ which java
/usr/bin/which: no java in (/usr/local/jdk-9.0.4/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/vagrant/.local/bin:/home/vagrant/bin)



- hosts: app
  roles:
    - oyj.java
~                                                                                                                             
oyj@Workstation-oyj-X555QG ~/.ansible$vi java_role.yml 
                                                                                                                      
~                                                                                                                             
~                                                                                                                             
~                                                                                                                             
~                          
 
oyj@Workstation-oyj-X555QG ~/.ansible$ansible-playbook java_role.yml --limit=ct7vag -b

PLAY [app] *******************************************************************************************************************

TASK [Gathering Facts] *******************************************************************************************************
ok: [ct7vag]

TASK [oyj.java : Ensure wget package installed] ******************************************************************************
ok: [ct7vag]

TASK [oyj.java : Ensure java.sh into /etc/profile.d] *************************************************************************
changed: [ct7vag]

TASK [oyj.java : script] *****************************************************************************************************
changed: [ct7vag]

TASK [oyj.java : debug] ******************************************************************************************************
ok: [ct7vag] => {
    "msg": "System ct7vag installed  jdk 9.0.4 in /usr/local/jdk-9.0.4"
}

PLAY RECAP *******************************************************************************************************************
ct7vag                     : ok=5    changed=2    unreachable=0    failed=0   

Test
[vagrant@ct7vag ~]$ which java
/usr/local/jdk-9.0.4/bin/java
[vagrant@ct7vag ~]$ 

This java playbook is applicable on any linux distro(ubuntu,centos,redhat...).
My first java role is successful.


Create tomcat role.
oyj@Workstation-oyj-X555QG ~/.ansible/roles$mkdir oyj.tomcat
oyj@Workstation-oyj-X555QG ~/.ansible/roles$mkdir oyj.tomcat/tasks
oyj@Workstation-oyj-X555QG ~/.ansible/roles$mkdir oyj.tomcat/vars
oyj@Workstation-oyj-X555QG ~/.ansible/roles$mkdir oyj.tomcat/templates

oyj@Workstation-oyj-X555QG ~/.ansible/roles/oyj.tomcat$vi vars/main.yml 
---
tomcat_version: 8.5.29
target_dir: /usr/local
mirror_host: mirror.navercorp.com
java_home: /usr/local/jdk-9.0.4
tomcat_home: /usr/local/apache-tomcat-8.5.29
tomcat_http_port: 8080
ssh_port: 22
tomcat_user: tomcat
tomcat_group: tomcat


oyj@Workstation-oyj-X555QG ~/.ansible/roles/oyj.tomcat/tasks$vi useradd.yml 
---
- name: "Add tomcat group"
  group:
    name: "{{ tomcat_group }}"
    state: present
    gid: 321

    
- name: "Add tomcat user"
  user:
    name: "{{ tomcat_user }}"
    shell: /bin/false
    group: "{{ tomcat_group }}"
    uid:   123



oyj@Workstation-oyj-X555QG ~/.ansible/roles/oyj.tomcat/tasks$cat downuntar.yml 
---
- name: "Download tomcat {{ tomcat_version }}"
  get_url:
     url: "http://{{ mirror_host }}/apache/tomcat/tomcat-8/v8.5.29/bin/apache-tomcat-8.5.29.tar.gz"
     dest: "{{ target_dir }}"
     checksum: sha1:fdc2ac85282af82a494e352c35e33dcfe1dbab6b
  register: get_tomcat


- debug:
      msg: "System {{ inventory_hostname }} download  tomcat  {{ tomcat_version }} on server"
  when: get_tomcat|changed


- name: "Untar apache-tomcat-{{ tomcat_version }}"
  unarchive :
      src: "{{ target_dir}}/apache-tomcat-{{ tomcat_version }}.tar.gz"
      dest: "{{ target_dir }}"
      remote_src: yes


- debug:
      msg: "System {{ inventory_hostname }} untar tomcat {{ tomcat_version }}"
                                        


oyj@Workstation-oyj-X555QG ~/.ansible/roles/oyj.tomcat/tasks$cp ~/.ansible/firewalled_tomcat.yml ./
oyj@Workstation-oyj-X555QG ~/.ansible/roles/oyj.tomcat/tasks$cat firewalled_tomcat.yml 
---
- name: Run firewalld daemon and enable when not enabled.
  systemd:
    name: firewalld
    state: started
    enabled: true

- shell: |
       firewall-cmd --permanent --add-port={{ tomcat_http_port }}/tcp
       firewall-cmd --permanent --add-port={{ ssh_port }}/tcp
       firewall-cmd --reload



oyj@Workstation-oyj-X555QG ~/.ansible/roles/oyj.tomcat/tasks$vi ownership.yml 
---
- shell: |
    chgrp -R tomcat "{{ target_dir }}/apache-tomcat-{{ tomcat_version }}"
    chmod -R g+r  "{{ target_dir }}/apache-tomcat-{{ tomcat_version }}/conf"
    chmod  g+x  "{{ target_dir }}/apache-tomcat-{{ tomcat_version }}/conf"
    chown -R tomcat "{{ target_dir }}/apache-tomcat-{{ tomcat_version }}/webapps"
    chown -R tomcat "{{ target_dir }}/apache-tomcat-{{ tomcat_version }}/work"
    chown -R tomcat "{{ target_dir }}/apache-tomcat-{{ tomcat_version }}/temp"
    chown -R tomcat "{{ target_dir }}/apache-tomcat-{{ tomcat_version }}/logs"


- debug:
    msg: "Ownership set {{ target_dir }}/apache-tomcat-{{ tomcat_version }}"


oyj@Workstation-oyj-X555QG ~/.ansible/roles/oyj.tomcat/tasks$vi main.yml 
---
- include: useradd.yml
- include: downuntar.yml
- include: ownership.yml

- name: "Add JAVA_HOME TO /etc/profile.d/"
  template: src=templates/java.sh.j2 dest=/etc/profile.d/java.sh
     mode=0644

- debug:
    msg: "Add java_home to /etc/profile.d" 


- name: "Tomcat {{ tomcat_version }} systemd service add"
  template: src=templates/tomcat_service.j2 dest=/etc/systemd/system/tomcat.service
     mode=0755
  
- debug:
    msg: "Tomcat {{ tomcat_version }} add to systemd service" 


- shell: |
    systemctl daemon-reload
    systemctl enable tomcat
    systemctl start tomcat

- debug:
    msg: "Tomcat {{ tomcat_version }} add to systemd service start" 

- include: firewalled_tomcat.yml
  when: ansible_os_family == 'RedHat' and ansible_distribution_version.split('.')[0] == '7'

     
- debug:
   msg: "For Centos7 only,Enable firewalld service and open Tomcat {{ tomcat_http_port }} and {{ ssh_port }}  firewalld open" 





oyj@Workstation-oyj-X555QG ~/.ansible/roles/oyj.tomcat$cp ~/.ansible/templates/java.sh.j2 templates/
oyj@Workstation-oyj-X555QG ~/.ansible/roles/oyj.tomcat$cp ~/.ansible/templates/tomcat_service.j2 templates/
oyj@Workstation-oyj-X555QG ~/.ansible/roles/oyj.tomcat$cat templates/java.sh.j2 
export JAVA_HOME=/usr/local/{{ java_home }}
export PATH={{ java_home }}/bin:$PATH
oyj@Workstation-oyj-X555QG ~/.ansible/roles/oyj.tomcat$cat templates/tomcat_service.j2 
# Systemd unit file for tomcat
[Unit]
Description=Apache Tomcat Web Application Container
After=syslog.target network.target

[Service]
Type=forking

Environment=JAVA_HOME={{ java_home }}
Environment=CATALINA_PID={{ tomcat_home}}/temp/tomcat.pid
Environment=CATALINA_HOME={{ tomcat_home }}
Environment=CATALINA_BASE={{ tomcat_home }}
Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'

ExecStart={{ tomcat_home }}/bin/startup.sh
ExecStop=/bin/kill -15 $MAINPID

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target


--------------------------------------------

Test

oyj@Workstation-oyj-X555QG ~/.ansible$cat tomcat_role.yml 
- hosts: app
  roles:
    - oyj.tomcat

Now, only centos7 distro.
Todo is centos6, ubuntu14...etc.

To be prepare.
[root@ct7vag ~]# systemctl stop tomcat

[root@ct7vag ~]# systemctl disable tomcat

[root@ct7vag ~]# rm -rf /usr/local/apache-tomcat*
[root@ct7vag ~]# rm -f /etc/systemd/system/tomcat.service
[root@ct7vag ~]# userdel tomcat
[root@ct7vag ~]# groupdel tomcat

From ansible control workstation.
oyj@Workstation-oyj-X555QG ~/.ansible$ansible-playbook tomcat_role.yml --limit=ct7vag -b
oyj@Workstation-oyj-X555QG ~/.ansible$ansible-playbook tomcat_role.yml --limit=ct7vag -b

PLAY [app] **************************************************************************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************************************************************
ok: [ct7vag]

TASK [oyj.tomcat : Add tomcat group] ************************************************************************************************************************************
changed: [ct7vag]

TASK [oyj.tomcat : Add tomcat user] *************************************************************************************************************************************
changed: [ct7vag]

TASK [oyj.tomcat : Download tomcat 8.5.29] ******************************************************************************************************************************
changed: [ct7vag]

TASK [oyj.tomcat : debug] ***********************************************************************************************************************************************
ok: [ct7vag] => {
    "msg": "System ct7vag download  tomcat  8.5.29 on server"
}

TASK [oyj.tomcat : Untar apache-tomcat-8.5.29] **************************************************************************************************************************
changed: [ct7vag]

TASK [oyj.tomcat : debug] ***********************************************************************************************************************************************
ok: [ct7vag] => {
    "msg": "System ct7vag untar tomcat 8.5.29"
}

TASK [oyj.tomcat : shell] ***********************************************************************************************************************************************
 [WARNING]: Consider using the file module with group rather than running chgrp.  If you need to use command because file is insufficient you can add warn=False to this
command task or set command_warnings=False in ansible.cfg to get rid of this message.

changed: [ct7vag]

TASK [oyj.tomcat : debug] ***********************************************************************************************************************************************
ok: [ct7vag] => {
    "msg": "Ownership set /usr/local/apache-tomcat-8.5.29"
}

TASK [oyj.tomcat : Add JAVA_HOME TO /etc/profile.d/] ********************************************************************************************************************
ok: [ct7vag]

TASK [oyj.tomcat : debug] ***********************************************************************************************************************************************
ok: [ct7vag] => {
    "msg": "Add java_home to /etc/profile.d"
}

TASK [oyj.tomcat : Tomcat 8.5.29 systemd service add] *******************************************************************************************************************
changed: [ct7vag]

TASK [oyj.tomcat : debug] ***********************************************************************************************************************************************
ok: [ct7vag] => {
    "msg": "Tomcat 8.5.29 add to systemd service"
}

TASK [oyj.tomcat : shell] ***********************************************************************************************************************************************
changed: [ct7vag]

TASK [oyj.tomcat : debug] ***********************************************************************************************************************************************
ok: [ct7vag] => {
    "msg": "Tomcat 8.5.29 add to systemd service start"
}

TASK [oyj.tomcat : Run firewalld daemon and enable when not enabled.] ***************************************************************************************************
ok: [ct7vag]

TASK [oyj.tomcat : shell] ***********************************************************************************************************************************************
changed: [ct7vag]

TASK [oyj.tomcat : debug] ***********************************************************************************************************************************************
ok: [ct7vag] => {
    "msg": "For Centos7 only,Enable firewalld service and open Tomcat 8080 and 22  firewalld open"
}

PLAY RECAP **************************************************************************************************************************************************************
ct7vag                     : ok=18   changed=8    unreachable=0    failed=0   



##########################################################################################################################################################################
Goal:
     This playbook of tomcat role only works for centos7 but I want to this work for centos6 that use "chkconfig and services" instead of systemd and systemctl.
     Also, I want to collate java_role and tomcat_role.
###########################################################################################################################################################################
First I added centos6 part to main.yml like belows.
oyj@Workstation-oyj-X555QG ~/.ansible/roles/oyj.tomcat$vi tasks/main.yml 
---
- include: useradd.yml
- include: downuntar.yml
- include: ownership.yml

- name: "Add JAVA_HOME TO /etc/profile.d/"
  template: src=templates/java.sh.j2 dest=/etc/profile.d/java.sh
     mode=0644

- debug:
    msg: "Add java_home to /etc/profile.d" 


- name: "Tomcat {{ tomcat_version }} systemd add"
  template: src=templates/tomcat_service.j2 dest=/etc/systemd/system/tomcat.service
     mode=0755
  when: ansible_os_family == 'RedHat' and ansible_distribution_version.split('.')[0] == '7'
  
- debug:
    msg: "Tomcat {{ tomcat_version }} add to systemd service" 

- shell: |
    systemctl daemon-reload
    systemctl enable tomcat
    systemctl start tomcat
  when: ansible_os_family == 'RedHat' and ansible_distribution_version.split('.')[0] == '7'

- debug:
    msg: "Tomcat {{ tomcat_version }} add to systemd service start" 


- name: "Tomcat {{ tomcat_version }} service add"
  template: src=templates/centos6_tomcat_service.j2 dest=/etc/init.d/tomcat
     mode=0755
  when: ansible_os_family == 'RedHat' and ansible_distribution_version.split('.')[0] == '6'

- name: "Start {{ tomcat_version }} service start"
  service:
     name: tomcat
     state: started
     enabled: yes
  when: ansible_os_family == 'RedHat' and ansible_distribution_version.split('.')[0] == '6'



- include: firewalled_tomcat.yml
  when: ansible_os_family == 'RedHat' and ansible_distribution_version.split('.')[0] == '7'
     
- debug:
   msg: "For Centos7 only,Enable firewalld service and open Tomcat {{ tomcat_http_port }} and {{ ssh_port }}  firewalld open" 

#Start script
oyj@Workstation-oyj-X555QG ~/.ansible/roles/oyj.tomcat$cat templates/centos6_tomcat_service.j2 
#!/bin/bash
#
# tomcat8
#
# chkconfig: - 80 20
#
### BEGIN INIT INFO
# Provides: tomcat8
# Required-Start: $network $syslog
# Required-Stop: $network $syslog
# Default-Start:
# Default-Stop:
# Description: Tomcat 8
# Short-Description: start and stop tomcat
### END INIT INFO
### This script is from "https://www.rosehosting.com/blog/how-to-install-tomcat-8-on-a-centos-6-vps/"
## Source function library.
#. /etc/rc.d/init.d/functions
export JAVA_HOME="{{ java_home }}"
export JAVA_OPTS="-Dfile.encoding=UTF-8 \
  -Dnet.sf.ehcache.skipUpdateCheck=true \
  -XX:+UseConcMarkSweepGC \
  -XX:+CMSClassUnloadingEnabled \
  -XX:+UseParNewGC \
  -XX:MaxPermSize=128m \
  -Xms512m -Xmx512m"
export PATH=$JAVA_HOME/bin:$PATH
TOMCAT_HOME={{ tomcat_home }}
TOMCAT_USER={{ tomcat_user }}
SHUTDOWN_WAIT=20

tomcat_pid() {
  echo `ps aux | grep org.apache.catalina.startup.Bootstrap | grep -v grep | awk '{ print $2 }'`
}

start() {
  pid=$(tomcat_pid)
  if [ -n "$pid" ] 
  then
    echo "Tomcat is already running (pid: $pid)"
  else
    # Start tomcat
    echo "Starting tomcat"
    ulimit -n 100000
    umask 007
    /bin/su -p -s /bin/sh $TOMCAT_USER $TOMCAT_HOME/bin/startup.sh
  fi


  return 0
}

stop() {
  pid=$(tomcat_pid)
  if [ -n "$pid" ]
  then
    echo "Stoping Tomcat"
    /bin/su -p -s /bin/sh $TOMCAT_USER $TOMCAT_HOME/bin/shutdown.sh

    let kwait=$SHUTDOWN_WAIT
    count=0;
    until [ `ps -p $pid | grep -c $pid` = '0' ] || [ $count -gt $kwait ]
    do
      echo -n -e "\nwaiting for processes to exit";
      sleep 1
      let count=$count+1;
    done

    if [ $count -gt $kwait ]; then
      echo -n -e "\nkilling processes which didn't stop after $SHUTDOWN_WAIT seconds"
      kill -9 $pid
    fi
  else
    echo "Tomcat is not running"
  fi
 
  return 0
}

case $1 in
start)
  start
;; 
stop)   
  stop
;; 
restart)
  stop
  start
;;
status)
  pid=$(tomcat_pid)
  if [ -n "$pid" ]
  then
    echo "Tomcat is running with pid: $pid"
  else
    echo "Tomcat is not running"
  fi
;; 
esac    
exit 0

#Now create and run java_tomcat.yml playboook.
oyj@Workstation-oyj-X555QG ~/.ansible$vi java_tomcat.yml 
- hosts: app
  roles:
    - oyj.java
    - oyj.tomcat


oyj@Workstation-oyj-X555QG ~/.ansible$ansible-playbook java_tomcat.yml --limit=ct6vag -b

PLAY [app] ***********************************************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************************
ok: [ct6vag]

TASK [oyj.java : Ensure wget package installed] **********************************************************************************************
ok: [ct6vag]

TASK [oyj.java : Ensure java.sh into /etc/profile.d] *****************************************************************************************
changed: [ct6vag]

TASK [oyj.java : script] *********************************************************************************************************************
changed: [ct6vag]

TASK [oyj.java : debug] **********************************************************************************************************************
ok: [ct6vag] => {
    "msg": "System ct6vag installed  jdk 9.0.4 in /usr/local/jdk-9.0.4"
}

TASK [oyj.tomcat : Add tomcat group] *********************************************************************************************************
ok: [ct6vag]

TASK [oyj.tomcat : Add tomcat user] **********************************************************************************************************
ok: [ct6vag]

TASK [oyj.tomcat : Download tomcat 8.5.29] ***************************************************************************************************
changed: [ct6vag]

TASK [oyj.tomcat : debug] ********************************************************************************************************************
ok: [ct6vag] => {
    "msg": "System ct6vag download  tomcat  8.5.29 on server"
}

TASK [oyj.tomcat : Untar apache-tomcat-8.5.29] ***********************************************************************************************
changed: [ct6vag]

TASK [oyj.tomcat : debug] ********************************************************************************************************************
ok: [ct6vag] => {
    "msg": "System ct6vag untar tomcat 8.5.29"
}

TASK [oyj.tomcat : shell] ********************************************************************************************************************
 [WARNING]: Consider using the file module with group rather than running chgrp.  If you need to use command because file is insufficient you
can add warn=False to this command task or set command_warnings=False in ansible.cfg to get rid of this message.

changed: [ct6vag]

TASK [oyj.tomcat : debug] ********************************************************************************************************************
ok: [ct6vag] => {
    "msg": "Ownership set /usr/local/apache-tomcat-8.5.29"
}

TASK [oyj.tomcat : Add JAVA_HOME TO /etc/profile.d/] *****************************************************************************************
changed: [ct6vag]

TASK [oyj.tomcat : debug] ********************************************************************************************************************
ok: [ct6vag] => {
    "msg": "Add java_home to /etc/profile.d"
}

TASK [oyj.tomcat : Tomcat 8.5.29 systemd add] ************************************************************************************************
skipping: [ct6vag]

TASK [oyj.tomcat : debug] ********************************************************************************************************************
ok: [ct6vag] => {
    "msg": "Tomcat 8.5.29 add to systemd service"
}

TASK [oyj.tomcat : shell] ********************************************************************************************************************
skipping: [ct6vag]

TASK [oyj.tomcat : debug] ********************************************************************************************************************
ok: [ct6vag] => {
    "msg": "Tomcat 8.5.29 add to systemd service start"
}

TASK [oyj.tomcat : Tomcat 8.5.29 service add] ************************************************************************************************
changed: [ct6vag]

TASK [oyj.tomcat : Start 8.5.29 service start] ***********************************************************************************************
ok: [ct6vag]

TASK [oyj.tomcat : Run firewalld daemon and enable when not enabled.] ************************************************************************
skipping: [ct6vag]

TASK [oyj.tomcat : shell] ********************************************************************************************************************
skipping: [ct6vag]

TASK [oyj.tomcat : debug] ********************************************************************************************************************
ok: [ct6vag] => {
    "msg": "For Centos7 only,Enable firewalld service and open Tomcat 8080 and 22  firewalld open"
}

PLAY RECAP ***********************************************************************************************************************************
ct6vag                     : ok=20   changed=7    unreachable=0    failed=0   



#Test
[root@ct6vag init.d]# ps -ef | grep tomcat
tomcat    9132     1  4 01:05 pts/0    00:00:17 /usr/local/jdk-9.0.4/bin/java -Djava.util.logging.config.file=/usr/local/apache-tomcat-8.5.29/conf/logging.properties -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Dfile.encoding=UTF-8 -Dnet.sf.ehcache.skipUpdateCheck=true -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -XX:+UseParNewGC -XX:MaxPermSize=128m -Xms512m -Xmx512m -Djdk.tls.ephemeralDHKeySize=2048 -Djava.protocol.handler.pkgs=org.apache.catalina.webresources -Dignore.endorsed.dirs= -classpath /usr/local/apache-tomcat-8.5.29/bin/bootstrap.jar:/usr/local/apache-tomcat-8.5.29/bin/tomcat-juli.jar -Dcatalina.base=/usr/local/apache-tomcat-8.5.29 -Dcatalina.home=/usr/local/apache-tomcat-8.5.29 -Djava.io.tmpdir=/usr/local/apache-tomcat-8.5.29/temp org.apache.catalina.startup.Bootstrap start
root     10283  5980  0 01:12 pts/0    00:00:00 grep tomcat
[root@ct6vag init.d]# chkconfig --list | grep tomcat
tomcat         	0:off	1:off	2:on	3:on	4:on	5:on	6:off


#Well Everything is ok.



####################################################################################################################################################################

Goal:To run any java-baed application, we need database. So, I would like to mysql  as a database server.
     Install roller blogger enginer based on java.


####################################################################################################################################################################

oyj@Workstation-oyj-X555QG ~/.ansible$ansible-galaxy install geerlingguy.mysql
- downloading role 'mysql', owned by geerlingguy
- downloading role from https://github.com/geerlingguy/ansible-role-mysql/archive/2.8.2.tar.gz
- extracting geerlingguy.mysql to /home/oyj/.ansible/roles/geerlingguy.mysql
- geerlingguy.mysql (2.8.2) was installed successfully


Enough memory on db mysql server would be better cause lack of memory could make running error.
oyj@Workstation-oyj-X555QG ~/.ansible$vi hosts 

[app]
ct7vag
ct6vag

[db]
u16vag

[vagdev:vars]
ansible_ssh_user=vagrant
ansible_ssh_private_key_file=~/.ssh/id_rsa


oyj@Workstation-oyj-X555QG ~/.ansible$cat mysql.yml 
- hosts: db
  roles:
    - geerlingguy.mysql


oyj@Workstation-oyj-X555QG ~/.ansible$ansible-playbook mysql.yml -b

PLAY [db] **************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************************************************************************************************************
ok: [u16vag]

TASK [geerlingguy.mysql : Include OS-specific variables.] ***************************************************************************************************************************************************************
ok: [u16vag] => (item=/home/oyj/.ansible/roles/geerlingguy.mysql/vars/Debian.yml)

TASK [geerlingguy.mysql : Include OS-specific variables (RedHat).] ******************************************************************************************************************************************************
skipping: [u16vag]

TASK [geerlingguy.mysql : Define mysql_packages.] ***********************************************************************************************************************************************************************
ok: [u16vag]

TASK [geerlingguy.mysql : Define mysql_daemon.] *************************************************************************************************************************************************************************
ok: [u16vag]

TASK [geerlingguy.mysql : Define mysql_slow_query_log_file.] ************************************************************************************************************************************************************
ok: [u16vag]

TASK [geerlingguy.mysql : Define mysql_log_error.] **********************************************************************************************************************************************************************
ok: [u16vag]

TASK [geerlingguy.mysql : Define mysql_syslog_tag.] *********************************************************************************************************************************************************************
ok: [u16vag]

TASK [geerlingguy.mysql : Define mysql_pid_file.] ***********************************************************************************************************************************************************************
ok: [u16vag]

TASK [geerlingguy.mysql : Define mysql_config_file.] ********************************************************************************************************************************************************************
ok: [u16vag]

TASK [geerlingguy.mysql : Define mysql_config_include_dir.] *************************************************************************************************************************************************************
ok: [u16vag]

TASK [geerlingguy.mysql : Define mysql_socket.] *************************************************************************************************************************************************************************
ok: [u16vag]

TASK [geerlingguy.mysql : Define mysql_supports_innodb_large_prefix.] ***************************************************************************************************************************************************
ok: [u16vag]

TASK [geerlingguy.mysql : include] **************************************************************************************************************************************************************************************
skipping: [u16vag]

TASK [geerlingguy.mysql : include] **************************************************************************************************************************************************************************************
included: /home/oyj/.ansible/roles/geerlingguy.mysql/tasks/setup-Debian.yml for u16vag

TASK [geerlingguy.mysql : Check if MySQL is already installed.] *********************************************************************************************************************************************************
ok: [u16vag]

TASK [geerlingguy.mysql : Update apt cache if MySQL is not yet installed.] **********************************************************************************************************************************************
changed: [u16vag]

TASK [geerlingguy.mysql : Ensure MySQL Python libraries are installed.] *************************************************************************************************************************************************
changed: [u16vag]

TASK [geerlingguy.mysql : Ensure MySQL packages are installed.] *********************************************************************************************************************************************************
changed: [u16vag] => (item=[u'mysql-common', u'mysql-server'])

TASK [geerlingguy.mysql : Ensure MySQL is stopped after initial install.] ***********************************************************************************************************************************************
changed: [u16vag]

TASK [geerlingguy.mysql : Delete innodb log files created by apt package after initial install.] ************************************************************************************************************************
changed: [u16vag] => (item=ib_logfile0)
changed: [u16vag] => (item=ib_logfile1)

TASK [geerlingguy.mysql : include] **************************************************************************************************************************************************************************************
skipping: [u16vag]

TASK [geerlingguy.mysql : Check if MySQL packages were installed.] ******************************************************************************************************************************************************
ok: [u16vag]

TASK [geerlingguy.mysql : Copy my.cnf global MySQL configuration.] ******************************************************************************************************************************************************
changed: [u16vag]

TASK [geerlingguy.mysql : Verify mysql include directory exists.] *******************************************************************************************************************************************************
skipping: [u16vag]

TASK [geerlingguy.mysql : Copy my.cnf override files into include directory.] *******************************************************************************************************************************************

TASK [geerlingguy.mysql : Create slow query log file (if configured).] **************************************************************************************************************************************************
skipping: [u16vag]

TASK [geerlingguy.mysql : Create datadir if it does not exist] **********************************************************************************************************************************************************
changed: [u16vag]

TASK [geerlingguy.mysql : Set ownership on slow query log file (if configured).] ****************************************************************************************************************************************
skipping: [u16vag]

TASK [geerlingguy.mysql : Create error log file (if configured).] *******************************************************************************************************************************************************
changed: [u16vag]

TASK [geerlingguy.mysql : Set ownership on error log file (if configured).] *********************************************************************************************************************************************
changed: [u16vag]

TASK [geerlingguy.mysql : Ensure MySQL is started and enabled on boot.] *************************************************************************************************************************************************
changed: [u16vag]

TASK [geerlingguy.mysql : Get MySQL version.] ***************************************************************************************************************************************************************************
ok: [u16vag]

TASK [geerlingguy.mysql : Ensure default user is present.] **************************************************************************************************************************************************************
skipping: [u16vag]

TASK [geerlingguy.mysql : Copy user-my.cnf file with password credentials.] *********************************************************************************************************************************************
skipping: [u16vag]

TASK [geerlingguy.mysql : Disallow root login remotely] *****************************************************************************************************************************************************************
ok: [u16vag] => (item=DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1'))

TASK [geerlingguy.mysql : Get list of hosts for the root user.] *********************************************************************************************************************************************************
ok: [u16vag]

TASK [geerlingguy.mysql : Update MySQL root password for localhost root account (5.7.x).] *******************************************************************************************************************************
changed: [u16vag] => (item=localhost)

TASK [geerlingguy.mysql : Update MySQL root password for localhost root account (< 5.7.x).] *****************************************************************************************************************************
skipping: [u16vag] => (item=localhost) 

TASK [geerlingguy.mysql : Copy .my.cnf file with root password credentials.] ********************************************************************************************************************************************
changed: [u16vag]

TASK [geerlingguy.mysql : Get list of hosts for the anonymous user.] ****************************************************************************************************************************************************
ok: [u16vag]

TASK [geerlingguy.mysql : Remove anonymous MySQL users.] ****************************************************************************************************************************************************************

TASK [geerlingguy.mysql : Remove MySQL test database.] ******************************************************************************************************************************************************************
ok: [u16vag]

TASK [geerlingguy.mysql : Ensure MySQL databases are present.] **********************************************************************************************************************************************************

TASK [geerlingguy.mysql : Ensure MySQL users are present.] **************************************************************************************************************************************************************

TASK [geerlingguy.mysql : Ensure replication user exists on master.] ****************************************************************************************************************************************************
skipping: [u16vag]

TASK [geerlingguy.mysql : Check slave replication status.] **************************************************************************************************************************************************************
skipping: [u16vag]

TASK [geerlingguy.mysql : Check master replication status.] *************************************************************************************************************************************************************
skipping: [u16vag]

TASK [geerlingguy.mysql : Configure replication on the slave.] **********************************************************************************************************************************************************
skipping: [u16vag]

TASK [geerlingguy.mysql : Start replication.] ***************************************************************************************************************************************************************************
skipping: [u16vag]

RUNNING HANDLER [geerlingguy.mysql : restart mysql] *********************************************************************************************************************************************************************
 [WARNING]: Ignoring "sleep" as it is not used in "systemd"

changed: [u16vag]

PLAY RECAP **************************************************************************************************************************************************************************************************************
u16vag                     : ok=33   changed=13   unreachable=0    failed=0   

Now ALL READY TO INSTALL ROLLER BLOG ENGINE. 
