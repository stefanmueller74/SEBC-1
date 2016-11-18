## Teragen Command
    su bavaria
    time hadoop jar /opt/cloudera/parcels/CDH/lib/hadoop-0.20-mapreduce/hadoop-examples.jar \
    teragen -Dmapred.map.tasks=4 -D dfs.blocksize=16m -Dmapred.map.tasks.speculative.execution=false 51200000 tgen512m
    
## Time result
    real    1m1.641s
    user    0m5.747s
    sys     0m0.272s

## Output of hdfs dfs -ls /user/bavaria/tgen512m
    [bavaria@ip-172-31-16-4 ec2-user]$ hdfs dfs -ls /user/bavaria/tgen512m
    Found 5 items
    -rw-r--r--   3 bavaria bavaria          0 2016-11-18 19:48 /user/bavaria/tgen512m/_SUCCESS
    -rw-r--r--   3 bavaria bavaria 1280000000 2016-11-18 19:48 /user/bavaria/tgen512m/part-m-00000
    -rw-r--r--   3 bavaria bavaria 1280000000 2016-11-18 19:48 /user/bavaria/tgen512m/part-m-00001
    -rw-r--r--   3 bavaria bavaria 1280000000 2016-11-18 19:48 /user/bavaria/tgen512m/part-m-00002
    -rw-r--r--   3 bavaria bavaria 1280000000 2016-11-18 19:48 /user/bavaria/tgen512m/part-m-00003
    

## Blocks related to /user/bavaria/tgen512m: 308

[bavaria@ip-172-31-16-4 ec2-user]$ hadoop fsck  /user/bavaria/tgen512m
Connecting to namenode via http://ip-172-31-16-4.eu-central-1.compute.internal:50070
FSCK started by bavaria (auth:SIMPLE) from /172.31.16.4 for path /user/bavaria/tgen512m at Fri Nov 18 19:56:59 JST 2016
.....Status: HEALTHY
 Total size:    5120000000 B
 Total dirs:    1
 Total files:   5
 Total symlinks:                0
 Total blocks (validated):      308 (avg. block size 16623376 B)
 Minimally replicated blocks:   308 (100.0 %)
 Over-replicated blocks:        0 (0.0 %)
 Under-replicated blocks:       0 (0.0 %)
 Mis-replicated blocks:         0 (0.0 %)
 Default replication factor:    3
 Average block replication:     3.0
 Corrupt blocks:                0
 Missing replicas:              0 (0.0 %)
 Number of data-nodes:          4
 Number of racks:               1
