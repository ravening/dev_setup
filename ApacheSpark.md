# Apache Spark

## Setup spark
```
wget https://apache.newfountain.nl/spark/spark-2.4.5/spark-2.4.5-bin-hadoop2.7.tgz
tar -xvf spark-2.4.5-bin-hadoop2.7.tgz
cp -R spark-2.4.5-bin-hadoop2.7/ /usr/local/
ln -s /usr/local/spark-2.4.5-bin-hadoop2.7/ /usr/local/spark
export SPARK_HOME=/usr/local/spark
export PATH=$PATH:/usr/local/spark/bin
export SPARK_LOCAL_IP=0.0.0.0
apt-get -y install python3-pip
apt-get install openjdk-8-jdk -y
apt-get install openjdk-8-jre -y
wget https://downloads.lightbend.com/scala/2.13.2/scala-2.13.2.deb
dpkg -i scala-2.13.2.deb
```

Add `hostname` output to line `127.0.0.1` in `/etc/hosts` file


## Concepts

Spark context is the driver which manages the jobs. We can create multiple context but not recommended
RDD - Resilient distributed dataset
collection of elements partitioned across the nodes of the cluster which can be operated in parallel
RDD is immutable.
RDD:DAG:Transformation:Action

Spark can read from file, hdfs, cassandra and many others

## start shell
```
spark-shell
```

### Load file
```
val textFile = sc.textFile("/usr/local/spark/README.md")
```

### print first line
```
testFile.first
```

### Split the words
```
val tokenizedFileData = testFile.flatMap(line=>line.split(" "))
```

### Count the words with count
```
val countPrep = tokenizedFileData.map(word=>(word,1))
```

```
val counts = countPrep.reduceByKey((accumValue, newValue) => accumValue + newValue)
```

### Sort the words on count
```
val sortedCounts = counts.sortBy(kvPair=>kvPair._2, false)
```

### Save the result to file
```
sortedCounts.saveAsTextFile("/root/wordCount")
```

### You can also use
```
tokenizedFileData.countByValue
```


## Distrubute job
```
sc.paralleize(1 to 100)
```

Collect the values
```
res0.collect
```

Another way

```
sc.range(1,100).collect
```
