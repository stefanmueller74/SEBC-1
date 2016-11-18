# 0 Doing more basics stuff on ALL Nodes
# Commands
    #Swappiness
    echo vm.swappiness=1 >> /etc/sysctl.conf
    sudo sysctl -p /etc/sysctl.conf
    cat /etc/sysctl.conf
    cat /proc/sys/vm/swappiness
    # disable TPH at runtime
    echo never > /sys/kernel/mm/transparent_hugepage/enabled
    echo never > /sys/kernel/mm/transparent_hugepage/defrag
    # Install Services
    sudo yum -y install bind-utils
    yum -y install nscd
    service nscd start
    sudo yum -y install ntp
    service ntpd start
    # Checking result on Nodes
    service --status-all | grep -e nscd -e ntpd -e mysqld -e cloudera
# Results
### Node1
    [root@ip-172-31-16-4 ec2-user]# service --status-all | grep -e nscd -e ntpd -e mysqld -e cloudera
    mysqld (pid  10753) is running...
    nscd (pid 10865) is running...
    ntpd (pid  10905) is running...
### Node2
    [root@ip-172-31-16-5 ec2-user]#  service --status-all | grep -e nscd -e ntpd -e mysqld -e cloudera
    nscd (pid 9232) is running...
    ntpd (pid  9271) is running...
### Node3
    [root@ip-172-31-16-6 ec2-user]#     service --status-all | grep -e nscd -e ntpd -e mysqld -e cloudera
    nscd (pid 8689) is running...
    ntpd (pid  8728) is running...
### Node4
    [root@ip-172-31-16-7 ec2-user]#     service --status-all | grep -e nscd -e ntpd -e mysqld -e cloudera
    nscd (pid 8702) is running...
    ntpd (pid  8741) is running...
### Node5
    [root@ip-172-31-16-8 ec2-user]#     service --status-all | grep -e nscd -e ntpd -e mysqld -e cloudera
    nscd (pid 8698) is running...
    ntpd (pid  8737) is running...

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

## Installing  MySQL JDBC connector
    sudo mkdir -p /usr/share/java/
    sudo cp  /home/ec2-user/git-ak/Sources/mysql-connector-java-5.1.40-bin.jar /usr/share/java/mysql-connector-java.jar
    ls -l /usr/share/java/mysql-connector-java.jar

# 2 Install MySQL Client & JDBC Connector on other nodes
## Commands
    # MySQL Client
    sudo yum -y install yum-utils
    sudo yum -y install wget
    sudo wget https://dev.mysql.com/get/mysql57-community-release-el6-9.noarch.rpm
    sudo yum -y localinstall mysql57-community-release-el6-9.noarch.rpm
    sudo yum-config-manager --disable mysql57-community
    sudo yum-config-manager --enable mysql56-community
    sudo yum repolist enabled | grep "mysql.*-community.*"
    sudo yum -y install mysql-community-client
    sudo mysql --version
    # Install MySQL JDBC connector file.
    sudo mkdir -p /usr/share/java/
    sudo cp  /home/ec2-user/git-ak/Sources/mysql-connector-java-5.1.40-bin.jar /usr/share/java/mysql-connector-java.jar
    ls -l /usr/share/java/mysql-connector-java.jar
    echo " ------------------------- "
    sudo mysql --version
    ls -l /usr/share/java/mysql-connector-java.jar
## Results
### Node2
    [root@ip-172-31-16-5 ec2-user]#     sudo mysql --version
    mysql  Ver 14.14 Distrib 5.6.34, for Linux (x86_64) using  EditLine wrapper
    [root@ip-172-31-16-5 ec2-user]#     ls -l /usr/share/java/mysql-connector-java.jar
    -rw-r--r-- 1 root root 990927 Nov 18 18:12 /usr/share/java/mysql-connector-java.jar
### Node3
    [root@ip-172-31-16-6 ec2-user]#     sudo mysql --version
    mysql  Ver 14.14 Distrib 5.6.34, for Linux (x86_64) using  EditLine wrapper
    [root@ip-172-31-16-6 ec2-user]#     ls -l /usr/share/java/mysql-connector-java.jar
    -rw-r--r-- 1 root root 990927 Nov 18 18:13 /usr/share/java/mysql-connector-java.jar
### Node4
    [root@ip-172-31-16-7 ec2-user]#     sudo mysql --version
    mysql  Ver 14.14 Distrib 5.6.34, for Linux (x86_64) using  EditLine wrapper
    [root@ip-172-31-16-7 ec2-user]#     ls -l /usr/share/java/mysql-connector-java.jar
    -rw-r--r-- 1 root root 990927 Nov 18 18:14 /usr/share/java/mysql-connector-java.jar
### Node5
    [root@ip-172-31-16-8 Sources]#     sudo mysql --version
    mysql  Ver 14.14 Distrib 5.6.34, for Linux (x86_64) using  EditLine wrapper
    [root@ip-172-31-16-8 Sources]#     ls -l /usr/share/java/mysql-connector-java.jar
    -rw-r--r-- 1 root root 990927 Nov 18 18:07 /usr/share/java/mysql-connector-java.jar
