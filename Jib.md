# Building Docker images using Jib

Jib is used to build docker image without Dockerfile and push it to docker hub using maven

Configure the username and password in m2 settings file

```
<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">
 <servers>
   <server>
     <id>docker.io</id>
     <username><your docker username></username>
     <password>password</password>
   </server>
 </servers>
</settings>
```


1. Add the below plugin under the plugins component

```
<plugins>
  <plugin>
    <groupId>com.google.cloud.tools</groupId>
    <artifactId>jib-maven-plugin</artifactId>
    <version>1.8.0</version>
    <configuration>
    	<from>
	    <image>adoptopenjdk/openjdk11:alpine-jre</image>
        </from>
	<container>
		<useCurrentTimestamp>true</useCurrentTimestamp>
		<ports>
		    <port>8080</port>
		</ports>
	</container>
        <to>
         	<image>springbootjib</image>
		<tags>
		    <tag>${project.version}</tag>
		</tags>
        </to>
   </configuration>
   
   
   <!-- Add the below section if you wan the docker image to be built after succesful build
   <executions>
        <execution>
            <phase>package</phase>
            <goals>
                <goal>build</goal>
            </goals>
        </execution>
    </executions>
    -->
    
  </plugin>
</plugins>
```


2. This command will build a docker image but does not push the image. Needs a running docker
```
mvn compile jib:dockerBuild
```

3. This will build docker image and pushed it to docker hub as well
```
mvn compile jib:build
```

4. This will compile project, builds docker image and pushes it to docker hub
```
mvn clean package -DskipTests
```
