# 1 Installing CDH

## Latest version of CDH: CDH-5.7.5-1.cdh5.7.5.p0.3
    Select the version of CDH
    CDH-5.7.5-1.cdh5.7.5.p0.3
    CDH-4.7.1-1.cdh4.7.1.p0.47
    *Versions of CDH that are too new for this version of Cloudera Manager (5.7.4) will not be shown.*
## Create user directories in HDFS for bavaria and saxony
    Switch to HDFS super user to create directory
    su hdfs
    hdfs dfs -mkdir /user/bavaria
    hdfs dfs -chown bavaria:bavaria /user/bavaria
    hdfs dfs -mkdir /user/saxony
    hdfs dfs -chown saxony:saxony /user/saxony
    exit
    
# Results
## SHOW GRANTS
    mysql> show grants for rman;
    +-----------------------------------------------------------------------------------------------------+
    | Grants for rman@%                                                                                   |
    +-----------------------------------------------------------------------------------------------------+
    | GRANT USAGE ON *.* TO 'rman'@'%' IDENTIFIED BY PASSWORD '*AEF345BFE495D8E678EA9D3D5708FD110AD2F08E' |
    | GRANT ALL PRIVILEGES ON `rman`.* TO 'rman'@'%'                                                      |
    +-----------------------------------------------------------------------------------------------------+
    2 rows in set (0.00 sec)

    mysql> show grants for hive;
    +-----------------------------------------------------------------------------------------------------+
    | Grants for hive@%                                                                                   |
    +-----------------------------------------------------------------------------------------------------+
    | GRANT USAGE ON *.* TO 'hive'@'%' IDENTIFIED BY PASSWORD '*8AC2E431CC7A9F2C4C0E51A65B8D8175892D9F22' |
    | GRANT ALL PRIVILEGES ON `hive`.* TO 'hive'@'%'                                                      |
    +-----------------------------------------------------------------------------------------------------+
    2 rows in set (0.00 sec)

    mysql> show grants for scm;
    +----------------------------------------------------------------------------------------------------+
    | Grants for scm@%                                                                                   |
    +----------------------------------------------------------------------------------------------------+
    | GRANT USAGE ON *.* TO 'scm'@'%' IDENTIFIED BY PASSWORD '*E2D6A4ADCCA7B38098E85EAF9BB785AB21451139' |
    +----------------------------------------------------------------------------------------------------+
    1 row in set (0.00 sec)

## Command and output for hdfs dfs -ls /user
    [root@ip-172-31-16-4 ec2-user]# hdfs dfs -ls /user
    Found 6 items
    drwxr-xr-x   - bavaria bavaria          0 2016-11-18 19:27 /user/bavaria
    drwxrwxrwx   - mapred  hadoop           0 2016-11-18 19:25 /user/history
    drwxrwxr-t   - hive    hive             0 2016-11-18 19:27 /user/hive
    drwxrwxr-x   - hue     hue              0 2016-11-18 19:27 /user/hue
    drwxrwxr-x   - oozie   oozie            0 2016-11-18 19:27 /user/oozie
    drwxr-xr-x   - saxony  saxony           0 2016-11-18 19:27 /user/saxony

## The output from the CM API call ../api/v12/hosts

    {
      "items" : [ {
        "hostId" : "i-085e7701f60df0008",
        "ipAddress" : "172.31.16.4",
        "hostname" : "ip-172-31-16-4.eu-central-1.compute.internal",
        "rackId" : "/default",
        "hostUrl" : "http://ip-172-31-16-5.eu-central-1.compute.internal:7180/cmf/hostRedirect/i-085e7701f60df0008",
        "maintenanceMode" : false,
        "maintenanceOwners" : [ ],
        "commissionState" : "COMMISSIONED",
        "numCores" : 4,
        "numPhysicalCores" : 2,
        "totalPhysMemBytes" : 15664877568
      }, {
        "hostId" : "i-030667d5cc3034296",
        "ipAddress" : "172.31.16.5",
        "hostname" : "ip-172-31-16-5.eu-central-1.compute.internal",
        "rackId" : "/default",
        "hostUrl" : "http://ip-172-31-16-5.eu-central-1.compute.internal:7180/cmf/hostRedirect/i-030667d5cc3034296",
        "maintenanceMode" : false,
        "maintenanceOwners" : [ ],
        "commissionState" : "COMMISSIONED",
        "numCores" : 4,
        "numPhysicalCores" : 2,
        "totalPhysMemBytes" : 15664877568
      }, {
        "hostId" : "i-0651b131d9ca1e20f",
        "ipAddress" : "172.31.16.6",
        "hostname" : "ip-172-31-16-6.eu-central-1.compute.internal",
        "rackId" : "/default",
        "hostUrl" : "http://ip-172-31-16-5.eu-central-1.compute.internal:7180/cmf/hostRedirect/i-0651b131d9ca1e20f",
        "maintenanceMode" : false,
        "maintenanceOwners" : [ ],
        "commissionState" : "COMMISSIONED",
        "numCores" : 4,
        "numPhysicalCores" : 2,
        "totalPhysMemBytes" : 15664877568
      }, {
    "hostId" : "i-0dca4732055759e3f",
    "ipAddress" : "172.31.16.7",
    "hostname" : "ip-172-31-16-7.eu-central-1.compute.internal",
    "rackId" : "/default",
    "hostUrl" : "http://ip-172-31-16-5.eu-central-1.compute.internal:7180/cmf/hostRedirect/i-0dca4732055759e3f",
    "maintenanceMode" : false,
    "maintenanceOwners" : [ ],
    "commissionState" : "COMMISSIONED",
    "numCores" : 4,
    "numPhysicalCores" : 2,
    "totalPhysMemBytes" : 15664877568
  }, {
    "hostId" : "i-031d84b1c4a6139ab",
    "ipAddress" : "172.31.16.8",
    "hostname" : "ip-172-31-16-8.eu-central-1.compute.internal",
    "rackId" : "/default",
    "hostUrl" : "http://ip-172-31-16-5.eu-central-1.compute.internal:7180/cmf/hostRedirect/i-031d84b1c4a6139ab",
    "maintenanceMode" : false,
    "maintenanceOwners" : [ ],
    "commissionState" : "COMMISSIONED",
    "numCores" : 4,
    "numPhysicalCores" : 2,
    "totalPhysMemBytes" : 15664877568
  } ]
}
