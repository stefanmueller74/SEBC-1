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
    grant all on amon.* TO 'rman'@'%' IDENTIFIED BY 'rman_password';
    
    ## METASTORE database
    create database metastore DEFAULT CHARACTER SET utf8;
    grant all on amon.* TO 'hive'@'%' IDENTIFIED BY 'hive_password';
    
    ## SENTRY database
    create database sentry DEFAULT CHARACTER SET utf8;
    grant all on amon.* TO 'sentry'@'%' IDENTIFIED BY 'sentry_password';
    
    
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

  
#5 Add  MariaDB JDBC Driver JAR to Oozie

Cloudera recommends that you use the MySQL JDBC driver for MariaDB. 
Copy or symbolically link the MySQL JDBC driver JAR to the /var/lib/oozie/ directory.

    
    
