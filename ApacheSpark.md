# Apache Spark

## Concepts

Spark context is the driver which manages the jobs. We can create multiple context but not recommended
RDD - Resilient distributed dataset
collection of elements partitioned across the nodes of the cluster which can be operated in parallel
RDD is immutable.
RDD:DAG:Transformation:Action


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
