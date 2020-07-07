# Steps to build docker image and create kubernetes resources using maven

You can find more details in https://github.com/rohanKanojia/eclipse-jkube-demo-project

## Use below content to create a `Dockerfile`
```
FROM adoptopenjdk/openjdk11:alpine-jre
MAINTAINER Rakesh Venkatesh
ARG JAR_FILE=target/<file>.jar
WORKDIR  /opt/app
COPY ${JAR_FILE} app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
```

## Step 1. Add spotify maven plugin to build docker images

```
<plugin>
  <groupId>com.spotify</groupId>
  <artifactId>dockerfile-maven-plugin</artifactId>
  <version>1.4.13</version>
  <executions>
    <execution>
      <id>tag-latest</id>
      <goals>
        <goal>build</goal>
        <goal>tag</goal>
        <goal>push</goal>
      </goals>
      <configuration>
        <tag>latest</tag>
      </configuration>
    </execution>
    <execution>
      <id>tag-version</id>
      <goals>
        <goal>build</goal>
        <goal>tag</goal>
        <goal>push</goal>
      </goals>
      <configuration>
        <tag>${project.version}</tag>
      </configuration>
    </execution>
  </executions>
  <configuration>
    <useMavenSettingsForAuth>true</useMavenSettingsForAuth>
    <repository>docker.io/rakgenius/${project.artifactId}</repository>
    <tag>${project.version}</tag>
    <buildArgs>
      <JAR_FILE>target/${project.build.finalName}.jar</JAR_FILE>
    </buildArgs>
  </configuration>
</plugin>
```

Resource files will be located under
`target/classes/META-INF/jkube/kubernetes/`

## Step 2. Add eclipse jkube to generate resources
```
<plugin>
  <groupId>org.eclipse.jkube</groupId>
  <artifactId>kubernetes-maven-plugin</artifactId>
  <version>1.0.0-alpha-3</version>
  <executions>
    <execution>
      <goals>
        <goal>resource</goal>
      </goals>
    </execution>
  </executions>
</plugin>
```

## Step3. Build and create
```
mvn clean package
```
