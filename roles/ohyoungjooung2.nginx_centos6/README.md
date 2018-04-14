Role Name
=========
ohyoungjooung2.nginx_centos6

This role nginx support for only centos6 distros(CentOS6.x)

Requirements
------------
None

Role Variables
--------------


defaults/main.yml
--------------

    os_update: false # os_update true update os updates(centos6.x)
  
    nginx_cert_config: false #private TLS cloud be installed by setting "true" or "--extra-vasr="nginx_cert_config=true" option.
  
    os: centos # This is used for templates/nginx.repo.j2
  
    centos_version: 6 # This is used for template/nginx.repo.j2. In the furture, CentOS7 cloud be supported.
  
    daemon_name: nginx #nginx daemon_name
  
    server_name: "{{ ansible_eth1_ipv4.address }} " #cloud be changed for your domain or ip by setting --extra-vars. Private zone ip address
 
    name_vhost_enable: false #true to use name based virtual host sites-available sites-enable link mechanism

    proxy_balancer_enable: false

    proxy_balancer_method: ip_hash
   
    group_name: app
    
    max_fails: 3
   
    fail_timeout: 30s
    
    backend_port: 8080
    
    backend_server:
      - 10.0.0.100
      - 10.0.0.101

    redirect_ssl: false

     #Firewall related. set false to true for production usage: 22,80,443 tcp ports
     production_on: false
     allowed_tcp_ports:
           - 22
           - 80
           - 443
     allowed_udp_ports: []
     log_dropped_packets: true



    
vars/main.yml
--------------

    key_file: /etc/nginx/ssl/nginx.key #private tls key
    cert_file: /etc/nginx/ssl/nginx.cert #private tls cert
    config_file: /etc/nginx/conf.d/default.conf #default host
    ....

  


Dependencies
------------
  None

Example Playbook
----------------

         - hosts: servers
           roles:
                - { role: ohyoungjooung2.nginx_centos6 } #Basic nginx 80 port
               #- { role: ohyoungjooung2.nginx_centos6,nginx_cert_config: true } #Include TLS
               #- { role: ohyoungjooung2.nginx_centos6,os_update: true } #Include os update
               #- { role: ohyoungjooung2.nginx_centos6,proxy_balancer_enabled: true } #Include os update
               #- { role: ohyoungjooung2.nginx_centos6,name_vhost_enable: true } #Include vhost
               #- { role: ohyoungjooung2.nginx_centos6,name_vhost_enable: true,redirect_ssl } #all 80 to 443 ssl
               #- { role: ohyoungjooung2.nginx_centos6,name_vhost_enable: true,production_on: true #all firewall on


   
License
-------
    - MIT


Author Information
------------------
  
    - wnapdlf05@gmail.com
