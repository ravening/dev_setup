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

### Add below line under properties section

```
<properties>
    <jkube.generator.name>rakgenius/${project.name}:${project.version}</jkube.generator.name>
</properties>
```

### Add the below content under plugins section
```
<plugins>
  <plugin>
    <groupId>org.eclipse.jkube</groupId>
    <artifactId>kubernetes-maven-plugin</artifactId>
    <version>1.0.0-alpha-4</version>
  </plugin>
<plugins>
```

## Step3. Build and create docker image
```
mvn k8s:build
```

## Step 4: Push to docker hub

Push to docker hub using
```
mvn k8s:push
```

## Step 5: Generate kubernetes resource files

```
mvn k8s:resource
```

## Step 6: Deploy to kubernetes using
```
mvn k8s:apply
```


## Getting the logs
```
mvn k8s:log
```

## Debug the application
```
mvn k8s:debug
```


## If you just want to generate k8s resources and dont want to build docker image then add the below section under profiles
```
<plugins>
  <plugin>
    <groupId>org.eclipse.jkube</groupId>
    <artifactId>kubernetes-maven-plugin</artifactId>
    <version>1.0.0-alpha-4</version>
    <executions>
      <execution>
        <goals>
          <goal>resource</goal>
        </goals>
      </execution>
    </executions>
  </plugin>
<plugins>
```
