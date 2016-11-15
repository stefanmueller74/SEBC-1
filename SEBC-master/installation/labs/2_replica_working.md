#1 Install MariaDB
  yum install mariadb-server
  
  
#ERRORS  mariadb

161115 03:14:44 mysqld_safe Logging to '/var/log/mariadb.log'.
161115 03:14:44 mysqld_safe Starting mysqld daemon with databases from /var/lib/mysql

/usr/bin/mysqld_safe: line 139: /var/log/mariadb.log: Permission denied
/usr/bin/mysqld_safe: line 183: /var/log/mariadb.log: Permission denied

mysqld_safe mysqld from pid file /var/run/maridb/mariadb.pid ended
