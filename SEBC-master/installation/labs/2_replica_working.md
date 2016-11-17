#1 Install MariaDB
    yum install mariadb-server

    changing configuration following
    ...
    [mysqld]
    datadir=/var/lib/mysql
    socket=/var/lib/mysql/mysql.sock
    log_bin=/var/log/mariadb/mariadb_binary_log
    ...
    [mysqld_safe]
    log-error=/var/log/mariadb/mariadb.log
    pid-file=/var/run/mariadb/mariadb.pid
    systemctl start mariadb
    ystemctl status mariadb
  
#2 Running Secury Routings
    sudo /usr/bin/mysql_secure_installation
    DB Root-PW        andreas
  
#3 Installing JDBC driver
    URL: http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.40.tar.gz
    tar zxvf /home/ec2-user/sources/mysql-connector-java-5.1.40.tar.gz
    sudo mkdir -p /usr/share/java/
    sudo cp /home/ec2-user/sources/mysql-connector-java-5.1.40/mysql-connector-java-5.1.40-bin.jar /usr/share/java/mysql-connector-java.jar
   
#4 Creating CDH Databases
    mysql -u root -p
   
    ## AMON database
    create database amon DEFAULT CHARACTER SET utf8;
    grant all on amon.* TO 'amon'@'%' IDENTIFIED BY 'amon_password';
    
    ## RMON database
    create database rman DEFAULT CHARACTER SET utf8;
    grant all on rman.* TO 'rman'@'%' IDENTIFIED BY 'rman_password';
    
    ## METASTORE database
    create database metastore DEFAULT CHARACTER SET utf8;
    grant all on metastore.* TO 'hive'@'%' IDENTIFIED BY 'hive_password';
    
    ## SENTRY database
    create database sentry DEFAULT CHARACTER SET utf8;
    grant all on sentry.* TO 'sentry'@'%' IDENTIFIED BY 'sentry_password';
    
    ## Oozie database
    create database oozie DEFAULT CHARACTER SET utf8;
    grant all on oozie.* TO 'oozie'@'%' IDENTIFIED BY 'oozie_password';

    ## HUE database
    create database hue DEFAULT CHARACTER SET utf8;
    grant all on hue.* TO 'hue'@'%' IDENTIFIED BY 'hue_password';
    
    ## Results 
    MariaDB> show databases
    +--------------------+
    | Database           |
    +--------------------+
    | information_schema |
    | amon               |
    | metastore          |
    | mysql              |
    | performance_schema |
    | rman               |
    | sentry             |
    +--------------------+

# 6a Open Port 3306 across server

    In AWS attach new rule "TCP on Port 3306" to the appropriate security group

# 6b Configuring Replication

      # MASTER   : 54.93.221.40
      # Edge      : 54.93.126.39
      # Node 1    : 54.93.129.228
      # Node 2    : 54.93.221.116
      # Node 3    : 54.93.96.233

      GRANT REPLICATION SLAVE ON *.* TO 'root'@'ip-172-31-18-56.eu-central-1.compute.internal' IDENTIFIED BY 'andreas';
      SET GLOBAL binlog_format = 'ROW';
      FLUSH TABLES WITH READ LOCK;

     
      
## Checking Status on Master

    show master status;
    +---------------------------+----------+--------------+------------------+
    | File                      | Position | Binlog_Do_DB | Binlog_Ignore_DB |
    +---------------------------+----------+--------------+------------------+
    | mariadb_binary_log.000007 |      806 |              |                  |
    +---------------------------+----------+--------------+------------------+


## Install MYSQL on Replica 54.93.126.39
    sudo yum install mariadb-server
    sudo systemctl start mariadb
    sudo systemctl status mariadb
    sudo mkdir -p /usr/share/java/
    sudo cp /home/ec2-user/sources/mysql-connector-java-5.1.40/mysql-connector-java-5.1.40-bin.jar /usr/share/java/mysql-connector-java.jar
    sudo /usr/bin/mysql_secure_installation
    sudo service mariadb stop 
    sudo service mariadb start 
       
## Login to the replica server and configure a connection to the master
    
    mysql -u root -p
    CHANGE MASTER TO MASTER_HOST='ip-172-31-18-55.eu-central-1.compute.internal', MASTER_USER='root', MASTER_PASSWORD='andreas', \
    MASTER_LOG_FILE='mariadb_binary_log.000007', MASTER_LOG_POS=806;
    
## Slaves starten
    START SLAVE;
    SLAVE STATUS; 

#99 Add  MariaDB JDBC Driver JAR to Oozie
Cloudera recommends that you use the MySQL JDBC driver for MariaDB. 
Copy or symbolically link the MySQL JDBC driver JAR to the /var/lib/oozie/ directory.


    
