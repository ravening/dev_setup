# Spotify maven plugin to build docker images using maven

## Add below lines in `plugins` section of `pom.xml`

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

Outside of `plugins` section but within the `build` section, add the below line

```
<finalName>${project.name}</finalName>
```

## Build images using
```
mvn clean install -DskipTests
```

## push it
```
mvn dockerfile:push
```
