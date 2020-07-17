# All elasticsearch related queries

## index

```
curl 'localhost:9200/_cat/indices?v'
```

or 

```
curl -X GET "localhost:9200/twitter" | jq
```

### delete index
```
curl -XDELETE localhost:9200/twitter
```


## Documents

### search for all documents
```
curl http://localhost:9200/cloudstack-api/_search?pretty=true
```
