# Maven commands

## Generate a new maven project
```
mvn archetype:generate -DarchetypeGroupId=org.apache.maven.archetypes -DarchetypeArtifactId=maven-archetype-quickstart -DgroupId=com.rakeshv -DartifactId=<project name>
```

## Build packages
```
mvn clean package -DskipTests
mvn install package -DskipTests
```
