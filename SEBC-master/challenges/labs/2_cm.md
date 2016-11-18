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


# Installing on "node2" -> ip-172-31-16-5

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
    sudo /usr/share/cmf/schema/scm_prepare_database.sh  mysql scm scm scm_password -h ip-172-31-24-138.eu-central-1.compute.internal -P 3306

    service cloudera-scm-server start
 
