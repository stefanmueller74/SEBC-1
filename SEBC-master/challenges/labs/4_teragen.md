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
