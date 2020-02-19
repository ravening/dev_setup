# Step by step instruction to install GraalVm on Ubuntu

## Get the latest GraalVm binary file
https://github.com/oracle/graal/releases

Download the tar file into the machine
```bash
wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-20.0.0/graalvm-ce-java11-linux-amd64-20.0.0.tar.gz
```

## Extract the file
```bash
tar -xf graalvm-ce-java11-linux-amd64-20.0.0.tar.gz
```

## Move the directory
```bash
cp -R graalvm-ce-java11-20.0.0/ /usr/lib/jvm/
```

## Install the graalvm using the update-alternatives
```bash
update-alternatives --install /usr/bin/java java /usr/lib/jvm/graalvm-ce-java11-20.0.0/bin/java 2
```

## Change the default java to graalvm java
```bash
 update-alternatives --config java
 ```

 ## make sure that java version displays graalvm
 ```bash
 java -version

openjdk version "11.0.6" 2020-01-14
OpenJDK Runtime Environment GraalVM CE 20.0.0 (build 11.0.6+9-jvmci-20.0-b02)
OpenJDK 64-Bit Server VM GraalVM CE 20.0.0 (build 11.0.6+9-jvmci-20.0-b02, mixed mode, sharing)
```

## Export the path
```bash
vi ~/.profile

export GRAALGU=/usr/lib/jvm/graalvm-ce-java11-20.0.0/bin
export PATH=$JAVA_HOME/BIN:$GRAALGU:$PATH

source ~/.profile
```

## Install native image
```bash
gu install native-image
```
