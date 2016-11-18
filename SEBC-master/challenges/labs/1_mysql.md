# 1 Install MySQL SERVER

## Installing config manager
    sudo yum -y install yum-utils
    sudo yum -y install wget
    sudo wget https://dev.mysql.com/get/mysql57-community-release-el6-9.noarch.rpm
    sudo yum -y localinstall mysql57-community-release-el6-9.noarch.rpm
    sudo yum-config-manager --disable mysql57-community
    sudo yum-config-manager --enable mysql56-community

## Checking version is set to 5.6
    [root@ip-172-31-16-4 ec2-user]# sudo yum repolist enabled | grep "mysql.*-community.*"
    mysql-connectors-community MySQL Connectors Community                         24
    mysql-tools-community      MySQL Tools Community                              40
    mysql56-community          MySQL 5.6 Community Server                        316

## Installing mysql-server and starting the service

    sudo yum install mysql-community-server
    sudo service mysqld start
    
    Starting mysqld:                                           [  OK  ]

## Running Securitization
    mysql_secure_installation 

    a. Set password protection for the server --> PW: andik
    b. Revoke permissions for anonymous users       Y
    c. Disallow root login remotely?                N
    d. Remove test databases                        Y
    e. Refresh privileges in memory                 Y

    sudo service mysqld restart

## BREAK ###############################

# 2 Install Client on other nodes
## Node1
    sudo yum -y install yum-utils
    sudo yum -y install wget
    sudo wget https://dev.mysql.com/get/mysql57-community-release-el6-9.noarch.rpm
    sudo yum -y localinstall mysql57-community-release-el6-9.noarch.rpm
    sudo yum-config-manager --disable mysql57-community
    sudo yum-config-manager --enable mysql56-community
