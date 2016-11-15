# Get RepoFile for CM 5.x

    wget https://archive.cloudera.com/cm5/redhat/7/x86_64/cm/cloudera-manager.repo
    mv cloudera-manager.repo /etc/yum.repos.d/

## Edit repo file
    # Packages for Cloudera Manager, Version 5, on RedHat or CentOS 7 x86_64
    name=Cloudera Manager
    baseurl=https://archive.cloudera.com/cm5/redhat/7/x86_64/cm/5.8.2
    gpgkey =https://archive.cloudera.com/cm5/redhat/7/x86_64/cm/RPM-GPG-KEY-cloudera
    gpgcheck = 1



# Create DB for CM

## SCM database
    create database scm DEFAULT CHARACTER SET utf8;
    grant all on scm.* TO 'sentry'@'%' IDENTIFIED BY 'scm_password';

## Results 
    databases;
    +--------------------+
    | Database           |
    +--------------------+
    | information_schema |
    | amon               |
    | metastore          |
    | mysql              |
    | performance_schema |
    | rman               |
    | scm                |
    | sentry             |
    +--------------------+


# Install Oracle JDK
  sudo yum install oracle-j2sdk1.7
