# 1 Get Cloudera Manager

## Get RepoFile for CM 5.x
    wget https://archive.cloudera.com/cm5/redhat/7/x86_64/cm/cloudera-manager.repo
    mv cloudera-manager.repo /etc/yum.repos.d/

## Edit repo file
    # Packages for Cloudera Manager, Version 5, on RedHat or CentOS 7 x86_64
    name=Cloudera Manager
    baseurl=https://archive.cloudera.com/cm5/redhat/7/x86_64/cm/5.8.2
    gpgkey =https://archive.cloudera.com/cm5/redhat/7/x86_64/cm/RPM-GPG-KEY-cloudera
    gpgcheck = 1

## Install Cloudera Manager from Repo
    sudo yum install cloudera-manager-daemons cloudera-manager-server�

## Install Oracle JDK
  sudo yum install oracle-j2sdk1.7

# 2 Setup DB
## Prepare database: 
http://www.cloudera.com/documentation/enterprise/5-8-x/topics/cm_ig_installing_configuring_dbs.html#cmig_topic_5_2

    /usr/share/cmf/schema/scm_prepare_database.sh
    Parameters: 
    1. database-type 2. database-name 3. username 4. password scm_password
    /usr/share/cmf/schema/scm_prepare_database.sh  mysql scm scm 'scm_password'
    
## Create DB for CM

### SCM database
    create database scm DEFAULT CHARACTER SET utf8;
    grant all on scm.* TO 'scm'@'%' IDENTIFIED BY 'scm_password';
### Results 
    databases;
    +--------------------+
    | Database           |
    +--------------------+
    | scm                |
    +--------------------+
# 3 Start CM

## Login
* AWS: Port 7180 für die entsprechende SecurityGroup freigeben
* URL: http://54.93.221.40:7180/cmf/login
* Credentials: admin/admin

## Hosts im Cluster für CDH konfigurieren
    Adressbereich 172.31.18.[55-59]
    
    Optionen
    > Schritt 1: Version            5.8.2 über Parcel/Repo hinzufügen (http://archive.cloudera.com/cdh5/parcels/5.8.2/)
    > Schritt 2: Java:              NICHT installieren
    > Schritt 3: Einzelusermode:    NICHT aktivieren
    > Schritt 4: SSH-Zugangsdaten:  anderer User: ec2-user + KeyFile hochladen
    > Schritt 5: Check Installationsstatus
    > Schritt 6: n.a.
    > Schritt 7: Parcelss verteilen
    > Schritt 8: Host-Inspektor
    
    
