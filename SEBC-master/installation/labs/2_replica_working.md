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
