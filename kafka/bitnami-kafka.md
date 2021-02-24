# Creating kafka cluster using bitnami docker containers

```
curl -sSL https://raw.githubusercontent.com/bitnami/bitnami-docker-kafka/master/docker-compose.yml > docker-compose.yml

cat docker-compose.yml

version: '2'

networks:
  cloudstack:
    driver: bridge

services:
  zookeeper:
    image: 'docker.io/bitnami/zookeeper:3-debian-10'
    networks:
      - cloudstack
    ports:
      - '2181:2181'
    volumes:
      - 'zookeeper_data:/bitnami'
    environment:
      - ALLOW_ANONYMOUS_LOGIN=yes
  kafka:
    image: 'docker.io/bitnami/kafka:2-debian-10'
    networks:
      - cloudstack
    ports:
      - '9092:9092'
    volumes:
      - 'kafka_data:/bitnami'
      - '/root/kafka/cloudstack:/bitnami/cloudstack'
    environment:
      - KAFKA_CFG_ZOOKEEPER_CONNECT=zookeeper:2181
      - ALLOW_PLAINTEXT_LISTENER=yes
      - KAFKA_LISTENERS=PLAINTEXT://:9092
      - KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://localhost:9092
      - KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181
    depends_on:
      - zookeeper

volumes:
  zookeeper_data:
    driver: local
  kafka_data:
    driver: local
```

```
docker-compose up -d
```
