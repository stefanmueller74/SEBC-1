## Add user
  useradd andreaskrisor

## Switch to HDFS super user to create directory
  su hdfs
  hdfs dfs -mkdir /user/andreaskrisor
  hdfs dfs -chown andreaskrisor:andreaskrisor /user/andreaskrisor

## Run job
### Teragen creates row of 100 bytes so 500 MB / 100 = 00000000
  su andreaskrisor
  time hadoop jar /opt/cloudera/parcels/CDH/lib/hadoop-0.20-mapreduce/hadoop-examples.jar teragen -Dmapred.map.tasks=4 -D dfs.blocksize=32m -Dmapred.map.tasks.speculative.execution=false 500000000 terasort

## Result (almost 10 Gb unreplicated, avg size of block is 32Mb)
  hdfs dfs -du -h /user/andreaskrisor/terasort

  real	4m9.831s
  user	0m6.638s
  sys	0m0.533s

  hdfs fsck /user/andreaskrisor/terasort
  Connecting to namenode via http://ip-172-31-9-37.eu-west-1.compute.internal:50070

## Trying the terasort 
  time hadoop jar /opt/cloudera/parcels/CDH/lib/hadoop-0.20-mapreduce/hadoop-examples.jar terasort -Dmapred.map.tasks.speculative.execution=false terasort terasort_out 

  real	6m55.205s
  user	0m9.059s
  sys	0m0.332s

## Same thing limiting the block size for a mapper to take more data
  time hadoop jar /opt/cloudera/parcels/CDH/lib/hadoop-0.20-mapreduce/hadoop-examples.jar terasort -Dmapreduce.input.fileinputformat.split.minsize=134217728 -Dmapreduce.input.fileinputformat.split.maxsize=134217728 -Dmapred.map.tasks.speculative.execution=false terasort terasort_out 
