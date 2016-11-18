# Results
## ls -l /etc/yum.repos.d
    [root@ip-172-31-16-5 ec2-user]# ls -l /etc/yum.repos.d
    total 44
    -rw-r--r--. 1 root root 1991 Oct 23  2014 CentOS-Base.repo
    -rw-r--r--. 1 root root  647 Oct 23  2014 CentOS-Debuginfo.repo
    -rw-r--r--. 1 root root  289 Oct 23  2014 CentOS-fasttrack.repo
    -rw-r--r--. 1 root root  630 Oct 23  2014 CentOS-Media.repo
    -rw-r--r--. 1 root root 5394 Oct 23  2014 CentOS-Vault.repo
    -rw-r--r--  1 root root  293 Nov 18 18:37 cloudera-manager.repo
    -rw-r--r--. 1 root root  957 Nov  5  2012 epel.repo
    -rw-r--r--. 1 root root 1056 Nov  5  2012 epel-testing.repo
    -rw-r--r--  1 root root 1414 Nov 18 18:11 mysql-community.repo
    -rw-r--r--  1 root root 1440 Sep 12 19:32 mysql-community-source.repo
    
## Restricting GRANT on scm to CM machine

    mysql> revoke all on scm.* from 'scm'@'%';
    mysql> grant all on scm.* TO 'scm'@'172.31.16.5' IDENTIFIED BY 'scm_password';
    mysql> select * from information_schema.schema_privileges;
        +---------------------+---------------+--------------+-------------------------+--------------+
        | GRANTEE             | TABLE_CATALOG | TABLE_SCHEMA | PRIVILEGE_TYPE          | IS_GRANTABLE |
        +---------------------+---------------+--------------+-------------------------+--------------+
        | 'scm'@'172.31.16.5' | def           | scm          | SELECT                  | NO           |
        | 'scm'@'172.31.16.5' | def           | scm          | INSERT                  | NO           |
        | 'scm'@'172.31.16.5' | def           | scm          | UPDATE                  | NO           |
        | 'scm'@'172.31.16.5' | def           | scm          | DELETE                  | NO           |
        | 'scm'@'172.31.16.5' | def           | scm          | CREATE                  | NO           |
        | 'scm'@'172.31.16.5' | def           | scm          | DROP                    | NO           |
        | 'scm'@'172.31.16.5' | def           | scm          | REFERENCES              | NO           |
        | 'scm'@'172.31.16.5' | def           | scm          | INDEX                   | NO           |
        | 'scm'@'172.31.16.5' | def           | scm          | ALTER                   | NO           |
        | 'scm'@'172.31.16.5' | def           | scm          | CREATE TEMPORARY TABLES | NO           |
        | 'scm'@'172.31.16.5' | def           | scm          | LOCK TABLES             | NO           |
        | 'scm'@'172.31.16.5' | def           | scm          | EXECUTE                 | NO           |
        | 'scm'@'172.31.16.5' | def           | scm          | CREATE VIEW             | NO           |
        | 'scm'@'172.31.16.5' | def           | scm          | SHOW VIEW               | NO           |
        | 'scm'@'172.31.16.5' | def           | scm          | CREATE ROUTINE          | NO           |
        | 'scm'@'172.31.16.5' | def           | scm          | ALTER ROUTINE           | NO           |
        | 'scm'@'172.31.16.5' | def           | scm          | EVENT                   | NO           |
        | 'scm'@'172.31.16.5' | def           | scm          | TRIGGER                 | NO           |

## SCM_Prepare
     [root@ip-172-31-16-5 ec2-user]# sudo /usr/share/cmf/schema/scm_prepare_database.sh mysql scm scm scm_password -h 172.31.16.4 -P 3306
    JAVA_HOME=/usr/java/jdk1.7.0_67-cloudera
    Verifying that we can write to /etc/cloudera-scm-server
    Creating SCM configuration file in /etc/cloudera-scm-server
    Executing:  /usr/java/jdk1.7.0_67-cloudera/bin/java -cp /usr/share/java/mysql-connector-java.jar:/usr/share/java/oracle-connector-java.jar:/usr/share/cmf/schema/../lib/* com.cloudera.enterprise.dbutil.DbCommandExecutor /etc/cloudera-scm-server/db.properties com.cloudera.cmf.db.
    2016-11-18 18:52:51,287 [main] INFO  com.cloudera.enterprise.dbutil.DbCommandExecutor  - Successfully connected to database.
    All done, your SCM database is configured correctly!


# Installing on node2 (ip-172-31-16-5)

## Getting Repo for Redhat6 and configure for CM 5.7.4

    sudo wget https://archive.cloudera.com/cm5/redhat/6/x86_64/cm/cloudera-manager.repo
    sudo cp cloudera-manager.repo /etc/yum.repos.d/
    sudo mv cloudera-manager.repo  cloudera-manager.repo_backup
    sudo vi /etc/yum.repos.d/cloudera-manager.repo   

        [root@ip-172-31-16-5 ec2-user]# cat /etc/yum.repos.d/cloudera-manager.repo
        [cloudera-manager]
        # Packages for Cloudera Manager, Version 5, on RedHat or CentOS 6 x86_64
        name=Cloudera Manager
        baseurl=https://archive.cloudera.com/cm5/redhat/6/x86_64/cm/5.7.4
        gpgkey =https://archive.cloudera.com/cm5/redhat/6/x86_64/cm/RPM-GPG-KEY-cloudera
        gpgcheck = 1

# Installing CM
    sudo yum install cloudera-manager-daemons cloudera-manager-server

    sudo yum install oracle-j2sdk1.7

    /usr/share/cmf/schema/scm_prepare_database.sh
    Parameters: 1. database-type 2. database-name 3. username 4. password scm_password
    sudo /usr/share/cmf/schema/scm_prepare_database.sh  mysql scm scm scm_password -h 172.31.16.4 -P 3306

    [root@ip-172-31-16-5 ec2-user]# service cloudera-scm-server start
    Starting cloudera-scm-server:                              [  OK  ]
