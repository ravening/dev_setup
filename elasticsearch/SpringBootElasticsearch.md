Adding Reactive Elasticsearch support to Spring boot application

## Add the below dependency to pom.xml

```
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-elasticsearch</artifactId>
</dependency>
```

## Enable it in `application.properties`

```
spring.application.name=<YOUR APPLICATION NAME>
spring.data.elasticsearch.client.reactive.endpoints=<Elastich search host IP>:9200
spring.elasticsearch.rest.uris=http://<Elastich search host IP>:9200
```

## Define repositories

```
@Repository
public interface ElasticsearchLogRepository extends ReactiveCrudRepository<ElasticsearchLog, Long> {
}
```


## Add the annotation to the main spring boot application class

```
@EnableReactiveElasticsearchRepositories
```
