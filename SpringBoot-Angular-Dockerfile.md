# Build Spring boot Angular Docket image in one command

## This file explains how to combine spring boot backend with angular 8 frontend and build a docker image in one one command


## Setting up frontend

Make sure the angular frontend is located in directory called `frontend` or any other similar name
Change the content of `outputPath` in `angular.json` to
```
outputPath: ../backend/src/main/resources/static/
```

where `backend` is the folder where your spring boot project resides
Also run the command `npm install` in the `frontend` directory.

## Setting up the backend

Make sure that your spring boot is located in directory called `backend`

Add the below content to pom.xml under `build/plugins` section
```
<plugin>
  <groupId>org.codehaus.mojo</groupId>
  <artifactId>exec-maven-plugin</artifactId>
  <version>1.6.0</version>
  <executions>
      <execution>
          <id>npm install (initialize)</id>
          <goals>
              <goal>exec</goal>
          </goals>
          <phase>initialize</phase>
          <configuration>
              <executable>npm</executable>
              <arguments>
                  <argument>install</argument>
              </arguments>
          </configuration>
      </execution>
      <execution>
          <id>npm run build (initialize)</id>
          <goals>
              <goal>exec</goal>
          </goals>
          <phase>initialize</phase>
          <configuration>
              <executable>npm</executable>
              <arguments>
                  <argument>run</argument>
                  <argument>build</argument>
              </arguments>
          </configuration>
      </execution>
  </executions>
  <configuration>
      <executable>ng</executable>
      <workingDirectory>../frontend</workingDirectory>
      <arguments>
          <argument>build</argument>
      </arguments>
  </configuration>
</plugin>

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

Now the command to build frontend using `npm install`, `npm run build` is
```
mvn clean package -DskipTests
```

This will also build docker images because of maven spotify plugin
