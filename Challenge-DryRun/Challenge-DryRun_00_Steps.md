# Launching AWS instances

## Supported version 
* URL: http://www.cloudera.com/documentation/director/1-1-x/topics/director_deployment_requirements.html#concept_fxs_mpn_
* AMI: CentOS-6.5-base-20150305 - ami-98a79585
* Instance-type: m3.xlarge
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
* URL: https://dev.mysql.com/doc/mysql-repo-excerpt/5.6/en/linux-installation-yum-repo.html

### Download RepoFile
    wget https://dev.mysql.com/get/mysql57-community-release-el6-9.noarch.rpm
    sudo yum localinstall mysql57-community-release-el6-9.noarch.rpm
### Edit RepoFile
    vi /etc/yum.repos.d/mysql-community.repo
    => set 5.6 to enabled and 5.7 to disabled
### Install MYSQL
    sudo yum install mysql-community-server
    
## On all cluster nodes:
### Install  MySQL client package
    sudo yum -y install yum-utils
    sudo yum -y install wget
    sudo wget https://dev.mysql.com/get/mysql57-community-release-el6-9.noarch.rpm
    sudo yum -y localinstall mysql57-community-release-el6-9.noarch.rpm
    sudo yum-config-manager --disable mysql57-community
    sudo yum-config-manager --enable mysql56-community
    sudo yum repolist enabled | grep "mysql.*-community.*"
    sudo yum -y install mysql-community-client
    sudo mysql --version
    
### Install  MySQL JDBC connector file.
    sudo wget http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.40.tar.gz
    sudo tar zxvf mysql-connector-java-5.1.40.tar.gz
    sudo mkdir -p /usr/share/java/
    sudo cp ./mysql-connector-java-5.1.40/mysql-connector-java-5.1.40-bin.jar /usr/share/java/mysql-connector-java.jar
    ls -l /usr/share/java/mysql-connector-java.jar

## start MySQL service

    sudo service mysqld start
    
* Run Securization
        
        mysql_secure_installation 
    
        a. Set password protection for the server --> PW: cloudera
        b. Revoke permissions for anonymous users       Y
        c. Permit remote privileged login               N
        d. Remove test databases                        Y
        e. Refresh privileges in memory                 Y
       
        sudo service mysqld restart
    
* Create the following databases

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
        show databases;
        
## OUTPUT

* The command and output of `mysql --version`

        mysql --version
        
* The command and output for a list of databases in MySQL

        show databases;
   
* The command and output for a list of grants in MySQL

        select * from information_schema.schema_privileges;

# 2 Install CM 5.8.1 - on *Node 01*

## Get & Edit REPO File

        ### sudo wget https://archive.cloudera.com/cm5/redhat/7/x86_64/cm/cloudera-manager.repo
        sudo wget https://archive.cloudera.com/cm5/redhat/6/x86_64/cm/cloudera-manager.repo
        sudo cp cloudera-manager.repo /etc/yum.repos.d/
        sudo mv cloudera-manager.repo  cloudera-manager.repo_backup
    
        sudo vi /etc/yum.repos.d/cloudera-manager.repo   
        # Packages for Cloudera Manager, Version 5, on RedHat or CentOS 7 x86_64
        name=Cloudera Manager
        baseurl=https://archive.cloudera.com/cm5/redhat/6/x86_64/cm/5.8.1
        gpgkey =https://archive.cloudera.com/cm5/redhat/6/x86_64/cm/RPM-GPG-KEY-cloudera
        gpgcheck = 1

## Installing CM

        sudo yum install cloudera-manager-daemons cloudera-manager-server
        
        sudo yum install oracle-j2sdk1.7
        
        /usr/share/cmf/schema/scm_prepare_database.sh
        Parameters: 1. database-type 2. database-name 3. username 4. password scm_password
        sudo /usr/share/cmf/schema/scm_prepare_database.sh  mysql scm scm scm_password -h ip-172-31-24-138.eu-central-1.compute.internal -P 3306

        service cloudera-scm-server start
        
# 3 Installing CDH

    AWS: Port 7180 für die entsprechende SecurityGroup freigeben
    URL: http://54.93.124.224:7180
    Credentials: admin/admin

## Hosts im Cluster für CDH konfigurieren

* Adressbereich 172.31.24.[138-142]

* Optionen

        ** Schritt 1: Version            5.8.0 über Parcel/Repo hinzufügen (http://archive.cloudera.com/cdh5/parcels/5.8.0)
        ** Schritt 2: Java:              beides aktivieren
                        [x] Install Oracle Java SE Development Kit (JDK)
                        [X] Install Java Unlimited Strength Encryption Policy Files 
        ** Schritt 3: Einzelusermode:    NICHT aktivieren
        ** Schritt 4: SSH-Zugangsdaten:  anderer User: ec2-user + KeyFile hochladen
        ** Schritt 5: Check Installationsstatus
        ** Schritt 6: n.a.
        ** Schritt 7: Parcelss verteilen
        ** Schritt 8: Host-Inspektor

# 4 HDFS Smoketest

## Preparing: Create Directories for kang

        Switch to HDFS super user to create directory

        su hdfs
        hdfs dfs -mkdir /user/kang
        hdfs dfs -chown kang:kang /user/kang
        exit

## Teragen creates row of 100 bytes so 500 MB / 100 = 5000000

        su kang
        time hadoop jar /opt/cloudera/parcels/CDH/lib/hadoop-0.20-mapreduce/hadoop-examples.jar teragen -Dmapred.map.tasks=4 -D dfs.blocksize=32m -Dmapred.map.tasks.speculative.execution=false 5000000 terasort-01

        hdfs dfs -du -h /user/kang/terasort-01
        59.6 M  178.8 M  /user/andreaskrisor/terasort/part-m-00000
        59.6 M  178.8 M  /user/andreaskrisor/terasort/part-m-00001
        59.6 M  178.8 M  /user/andreaskrisor/terasort/part-m-00002
        59.6 M  178.8 M  /user/andreaskrisor/terasort/part-m-00003

### Result

          hdfs fsck /user/andreaskrisor/terasort
          Connecting to namenode via http://ip-172-31-9-37.eu-west-1.compute.internal:50070

        Trying the terasort

          time hadoop jar /opt/cloudera/parcels/CDH/lib/hadoop-0.20-mapreduce/hadoop-examples.jar terasort -Dmapred.map.tasks.speculative.execution=false terasort terasort_out 

            real    0m27.751s
            user    0m7.595s
            sys     0m0.350s

        Same thing limiting the block size for a mapper to take more data

          time hadoop jar /opt/cloudera/parcels/CDH/lib/hadoop-0.20-mapreduce/hadoop-examples.jar terasort -Dmapreduce.input.fileinputformat.split.minsize=134217728 -Dmapreduce.input.fileinputformat.split.maxsize=134217728 -Dmapred.map.tasks.speculative.execution=false terasort terasort_out 

            real    0m28.571s
            user    0m7.028s
            sys     0m0.400s
