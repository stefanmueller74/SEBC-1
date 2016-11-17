# Launching AWS instances

## Supported version 
* URL: http://www.cloudera.com/documentation/director/1-1-x/topics/director_deployment_requirements.html#concept_fxs_mpn_
* AMI: CentOS-6.5-base-20150305 - ami-98a79585
* Instance-type: CentOS-6.5-base-20150305 - ami-98a79585
* Attach Storage: 30GB

        Checking diskspace 
        df / -h
        du / -h | sort -hr | head

# 0 Setting up

## Install basic tools
    sudo yum install wget

## Swappiness
    echo vm.swappiness=1 >> /etc/sysctl.conf
    sudo sysctl -p /etc/sysctl.conf
    cat /etc/sysctl.conf
    cat /proc/sys/vm/swappiness

## disable TPH at runtime
    echo never > /sys/kernel/mm/transparent_hugepage/enabled
    echo never > /sys/kernel/mm/transparent_hugepage/defrag

## Install ServiceTools
    sudo yum install bind-utils
    yum install nscd
    service nscd start
    systemctl enable nscd.service

    sudo yum install ntp
    service ntpd start
    systemctl enable ntpd.service

## USER
    groupadd enslave
    groupadd destroy
    adduser kang  -u 2500 -G enslave
    adduser kodos -u 2501 -G destroy

### Checking users and groups
#### cat /etc/passwd | grep -e destroy -e enslave -e kang -e kodos
        kang:x:2500:2500::/home/kang:/bin/bash
        kodos:x:2501:2501::/home/kodos:/bin/bash
    
#### cat /etc/group | grep -e destroy -e enslave -e kang -e kodos 
        destroy:x:1002:kodos
        enslave:x:1003:kang
        kang:x:2500:
        kodos:x:2501:

## Check Services
        service --status-all | grep -e  nscd -e ntpd -e mysql -e cloud
       
# Challenge 1: Install a MySQL server

## Install MySQL 5.6.x using yum
* URL: http://dev.mysql.com/doc/refman/5.7/en/linux-installation-yum-repo.html

### Download RepoFile
    wget https://dev.mysql.com/get/mysql57-community-release-el6-9.noarch.rpm
    sudo yum localinstall mysql57-community-release-el6-9.noarch.rpm
### Edit RepoFile
    vi /etc/yum.repos.d/mysql-community.repo
    => set 5.6 to enabled and 5.7 to disabled
### Install MYSQL
    sudo yum install mysql-community-server
    
## On all cluster nodes:
    * Install the MySQL client package and the MySQL JDBC connector file.

## Start the `mysqld` service
    * Delete the `test` database
    * Create the following databases
        * `scm`
        * `rman`
        * `hive`
        * `oozie`
        * `hue`
        * `sentry`
## OUTPUT
    * The command and output of `mysql --version`
    * The command and output for a list of databases in MySQL
    * The command and output for a list of grants in MySQL
