# Generate File

hadoop jar /opt/cloudera/parcels/CDH/lib/hadoop-0.20-mapreduce/hadoop-examples.jar teragen -Dmapred.map.tasks=50 -Dmapred.map.tasks.speculative.execution=false 10000000 terasort
