# 1 Installing CDH

## Latest version of CDH: CDH-5.7.5-1.cdh5.7.5.p0.3
    Select the version of CDH
    CDH-5.7.5-1.cdh5.7.5.p0.3
    CDH-4.7.1-1.cdh4.7.1.p0.47
    *Versions of CDH that are too new for this version of Cloudera Manager (5.7.4) will not be shown.*

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


## Create user directories in HDFS for bavaria and saxony
## Command and output for hdfs dfs -ls /user
## The output from the CM API call ../api/v12/hosts
