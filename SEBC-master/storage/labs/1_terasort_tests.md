#1 Setting up 
## Add user
    useradd andreaskrisor
## Switch to HDFS super user to create directory
    su hdfs
    hdfs dfs -mkdir /user/andreaskrisor
    hdfs dfs -chown andreaskrisor:andreaskrisor /user/andreaskrisor

## Teragen creates row of 100 bytes so 500 MB / 100 = 5000000
    su andreaskrisor
    hadoop jar /opt/cloudera/parcels/CDH/lib/hadoop-0.20-mapreduce/hadoop-examples.jar teragen -Dmapred.map.tasks=4 -D dfs.blocksize=32m -Dmapred.map.tasks.speculative.execution=false 5000000 terasort

    hdfs dfs -du -h /user/andreaskrisor/terasort
    59.6 M  178.8 M  /user/andreaskrisor/terasort/part-m-00000
    59.6 M  178.8 M  /user/andreaskrisor/terasort/part-m-00001
    59.6 M  178.8 M  /user/andreaskrisor/terasort/part-m-00002
    59.6 M  178.8 M  /user/andreaskrisor/terasort/part-m-00003

## Result 
      hdfs fsck /user/andreaskrisor/terasort
      Connecting to namenode via http://ip-172-31-9-37.eu-west-1.compute.internal:50070

## Trying the terasort 
      time hadoop jar /opt/cloudera/parcels/CDH/lib/hadoop-0.20-mapreduce/hadoop-examples.jar terasort -Dmapred.map.tasks.speculative.execution=false terasort terasort_out 

        real    0m27.751s
        user    0m7.595s
        sys     0m0.350s

## Same thing limiting the block size for a mapper to take more data
      time hadoop jar /opt/cloudera/parcels/CDH/lib/hadoop-0.20-mapreduce/hadoop-examples.jar terasort -Dmapreduce.input.fileinputformat.split.minsize=134217728 -Dmapreduce.input.fileinputformat.split.maxsize=134217728 -Dmapred.map.tasks.speculative.execution=false terasort terasort_out 

        real    0m28.571s
        user    0m7.028s
        sys     0m0.400s
