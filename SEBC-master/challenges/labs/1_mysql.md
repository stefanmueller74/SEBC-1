# 0 Doing more basics stuff on ALL Nodes
## Commands
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
## Results
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
    
    [root@ip-172-31-16-4 ec2-user]# ls -l /usr/share/java/mysql-connector-java.jar
    -rw-r--r-- 1 root root 990927 Nov 18 18:16 /usr/share/java/mysql-connector-java.jar


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

# 3 Creating Databases
##  Create DBs
    mysql -u root -p
        create database scm DEFAULT CHARACTER SET utf8;
        grant all on scm.* TO 'scm'@'%' IDENTIFIED BY 'scm_password';
        create database rman DEFAULT CHARACTER SET utf8;
        grant all on rman.* TO 'rman'@'%' IDENTIFIED BY 'rman_password';
        create database hive DEFAULT CHARACTER SET utf8;
        grant all on hive.* TO 'hive'@'%' IDENTIFIED BY 'hive_password';
        create database oozie DEFAULT CHARACTER SET utf8;
        grant all on oozie.* TO 'oozie'@'%' IDENTIFIED BY 'oozie_password';
        create database hue DEFAULT CHARACTER SET utf8;
        grant all on hue.* TO 'hue'@'%' IDENTIFIED BY 'hue_password';
        create database sentry DEFAULT CHARACTER SET utf8;
        grant all on sentry.* TO 'sentry'@'%' IDENTIFIED BY 'sentry_password';
##  Results - MySQL Version
    # MySQL Version
    [root@ip-172-31-16-4 ec2-user]# mysql --version
    mysql  Ver 14.14 Distrib 5.6.34, for Linux (x86_64) using  EditLine wrapper
## Results DB list
    mysql>     show databases;
        +--------------------+
        | Database           |
        +--------------------+
        | information_schema |
        | hive               |
        | hue                |
        | mysql              |
        | oozie              |
        | performance_schema |
        | rman               |
        | scm                |
        | sentry             |
        +--------------------+
        9 rows in set (0.00 sec)
## Restuls Grants - reading the data dictionairy of mysql
<pre><code>
mysql> select * from information_schema.schema_privileges;
+--------------+---------------+--------------+-------------------------+--------------+
| GRANTEE      | TABLE_CATALOG | TABLE_SCHEMA | PRIVILEGE_TYPE          | IS_GRANTABLE |
+--------------+---------------+--------------+-------------------------+--------------+
| 'scm'@'%'    | def           | scm          | SELECT                  | NO           |
| 'scm'@'%'    | def           | scm          | INSERT                  | NO           |
| 'scm'@'%'    | def           | scm          | UPDATE                  | NO           |
| 'scm'@'%'    | def           | scm          | DELETE                  | NO           |
| 'scm'@'%'    | def           | scm          | CREATE                  | NO           |
| 'scm'@'%'    | def           | scm          | DROP                    | NO           |
| 'scm'@'%'    | def           | scm          | REFERENCES              | NO           |
| 'scm'@'%'    | def           | scm          | INDEX                   | NO           |
| 'scm'@'%'    | def           | scm          | ALTER                   | NO           |
| 'scm'@'%'    | def           | scm          | CREATE TEMPORARY TABLES | NO           |
| 'scm'@'%'    | def           | scm          | LOCK TABLES             | NO           |
| 'scm'@'%'    | def           | scm          | EXECUTE                 | NO           |
| 'scm'@'%'    | def           | scm          | CREATE VIEW             | NO           |
| 'scm'@'%'    | def           | scm          | SHOW VIEW               | NO           |
| 'scm'@'%'    | def           | scm          | CREATE ROUTINE          | NO           |
| 'scm'@'%'    | def           | scm          | ALTER ROUTINE           | NO           |
| 'scm'@'%'    | def           | scm          | EVENT                   | NO           |
| 'scm'@'%'    | def           | scm          | TRIGGER                 | NO           |
| 'rman'@'%'   | def           | rman         | SELECT                  | NO           |
| 'rman'@'%'   | def           | rman         | INSERT                  | NO           |
| 'rman'@'%'   | def           | rman         | UPDATE                  | NO           |
| 'rman'@'%'   | def           | rman         | DELETE                  | NO           |
| 'rman'@'%'   | def           | rman         | CREATE                  | NO           |
| 'rman'@'%'   | def           | rman         | DROP                    | NO           |
| 'rman'@'%'   | def           | rman         | REFERENCES              | NO           |
| 'rman'@'%'   | def           | rman         | INDEX                   | NO           |
| 'rman'@'%'   | def           | rman         | ALTER                   | NO           |
| 'rman'@'%'   | def           | rman         | CREATE TEMPORARY TABLES | NO           |
| 'rman'@'%'   | def           | rman         | LOCK TABLES             | NO           |
| 'rman'@'%'   | def           | rman         | EXECUTE                 | NO           |
| 'rman'@'%'   | def           | rman         | CREATE VIEW             | NO           |
| 'rman'@'%'   | def           | rman         | SHOW VIEW               | NO           |
| 'rman'@'%'   | def           | rman         | CREATE ROUTINE          | NO           |
| 'rman'@'%'   | def           | rman         | ALTER ROUTINE           | NO           |
| 'rman'@'%'   | def           | rman         | EVENT                   | NO           |
| 'rman'@'%'   | def           | rman         | TRIGGER                 | NO           |
| 'hive'@'%'   | def           | hive         | SELECT                  | NO           |
| 'hive'@'%'   | def           | hive         | INSERT                  | NO           |
| 'hive'@'%'   | def           | hive         | UPDATE                  | NO           |
| 'hive'@'%'   | def           | hive         | DELETE                  | NO           |
| 'hive'@'%'   | def           | hive         | CREATE                  | NO           |
| 'hive'@'%'   | def           | hive         | DROP                    | NO           |
| 'hive'@'%'   | def           | hive         | REFERENCES              | NO           |
| 'hive'@'%'   | def           | hive         | INDEX                   | NO           |
| 'hive'@'%'   | def           | hive         | ALTER                   | NO           |
| 'hive'@'%'   | def           | hive         | CREATE TEMPORARY TABLES | NO           |
| 'hive'@'%'   | def           | hive         | LOCK TABLES             | NO           |
| 'hive'@'%'   | def           | hive         | EXECUTE                 | NO           |
| 'hive'@'%'   | def           | hive         | CREATE VIEW             | NO           |
| 'hive'@'%'   | def           | hive         | SHOW VIEW               | NO           |
| 'hive'@'%'   | def           | hive         | CREATE ROUTINE          | NO           |
| 'hive'@'%'   | def           | hive         | ALTER ROUTINE           | NO           |
| 'hive'@'%'   | def           | hive         | EVENT                   | NO           |
| 'hive'@'%'   | def           | hive         | TRIGGER                 | NO           |
| 'oozie'@'%'  | def           | oozie        | SELECT                  | NO           |
| 'oozie'@'%'  | def           | oozie        | INSERT                  | NO           |
| 'oozie'@'%'  | def           | oozie        | UPDATE                  | NO           |
| 'oozie'@'%'  | def           | oozie        | DELETE                  | NO           |
| 'oozie'@'%'  | def           | oozie        | CREATE                  | NO           |
| 'oozie'@'%'  | def           | oozie        | DROP                    | NO           |
| 'oozie'@'%'  | def           | oozie        | REFERENCES              | NO           |
| 'oozie'@'%'  | def           | oozie        | INDEX                   | NO           |
| 'oozie'@'%'  | def           | oozie        | ALTER                   | NO           |
| 'oozie'@'%'  | def           | oozie        | CREATE TEMPORARY TABLES | NO           |
| 'oozie'@'%'  | def           | oozie        | LOCK TABLES             | NO           |
| 'oozie'@'%'  | def           | oozie        | EXECUTE                 | NO           |
| 'oozie'@'%'  | def           | oozie        | CREATE VIEW             | NO           |
| 'oozie'@'%'  | def           | oozie        | SHOW VIEW               | NO           |
| 'oozie'@'%'  | def           | oozie        | CREATE ROUTINE          | NO           |
| 'oozie'@'%'  | def           | oozie        | ALTER ROUTINE           | NO           |
| 'oozie'@'%'  | def           | oozie        | EVENT                   | NO           |
| 'oozie'@'%'  | def           | oozie        | TRIGGER                 | NO           |
| 'hue'@'%'    | def           | hue          | SELECT                  | NO           |
| 'hue'@'%'    | def           | hue          | INSERT                  | NO           |
| 'hue'@'%'    | def           | hue          | UPDATE                  | NO           |
| 'hue'@'%'    | def           | hue          | DELETE                  | NO           |
| 'hue'@'%'    | def           | hue          | CREATE                  | NO           |
| 'hue'@'%'    | def           | hue          | DROP                    | NO           |
| 'hue'@'%'    | def           | hue          | REFERENCES              | NO           |
| 'hue'@'%'    | def           | hue          | INDEX                   | NO           |
| 'hue'@'%'    | def           | hue          | ALTER                   | NO           |
| 'hue'@'%'    | def           | hue          | CREATE TEMPORARY TABLES | NO           |
| 'hue'@'%'    | def           | hue          | LOCK TABLES             | NO           |
| 'hue'@'%'    | def           | hue          | EXECUTE                 | NO           |
| 'hue'@'%'    | def           | hue          | CREATE VIEW             | NO           |
| 'hue'@'%'    | def           | hue          | SHOW VIEW               | NO           |
| 'hue'@'%'    | def           | hue          | CREATE ROUTINE          | NO           |
| 'hue'@'%'    | def           | hue          | ALTER ROUTINE           | NO           |
| 'hue'@'%'    | def           | hue          | EVENT                   | NO           |
| 'hue'@'%'    | def           | hue          | TRIGGER                 | NO           |
| 'sentry'@'%' | def           | sentry       | SELECT                  | NO           |
| 'sentry'@'%' | def           | sentry       | INSERT                  | NO           |
| 'sentry'@'%' | def           | sentry       | UPDATE                  | NO           |
| 'sentry'@'%' | def           | sentry       | DELETE                  | NO           |
| 'sentry'@'%' | def           | sentry       | CREATE                  | NO           |
| 'sentry'@'%' | def           | sentry       | DROP                    | NO           |
| 'sentry'@'%' | def           | sentry       | REFERENCES              | NO           |
| 'sentry'@'%' | def           | sentry       | INDEX                   | NO           |
| 'sentry'@'%' | def           | sentry       | ALTER                   | NO           |
| 'sentry'@'%' | def           | sentry       | CREATE TEMPORARY TABLES | NO           |
| 'sentry'@'%' | def           | sentry       | LOCK TABLES             | NO           |
| 'sentry'@'%' | def           | sentry       | EXECUTE                 | NO           |
| 'sentry'@'%' | def           | sentry       | CREATE VIEW             | NO           |
| 'sentry'@'%' | def           | sentry       | SHOW VIEW               | NO           |
| 'sentry'@'%' | def           | sentry       | CREATE ROUTINE          | NO           |
| 'sentry'@'%' | def           | sentry       | ALTER ROUTINE           | NO           |
| 'sentry'@'%' | def           | sentry       | EVENT                   | NO           |
| 'sentry'@'%' | def           | sentry       | TRIGGER                 | NO           |
+--------------+---------------+--------------+-------------------------+--------------+
108 rows in set (0.00 sec)
</code></pre>
