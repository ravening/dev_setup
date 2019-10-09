# Step by step instruction to install GraalVm on Ubuntu

## Get the latest GraalVm binary file
https://github.com/oracle/graal/releases

Download the tar file into the machine
```bash
wget https://github.com/oracle/graal/releases/download/vm-19.2.0.1/graalvm-ce-linux-amd64-19.2.0.1.tar.gz
```

## Extract the file
```bash
tar -xf graalvm-ce-linux-amd64-19.2.0.1.tar.gz
```

## Move the directory
```bash
cp -R graalvm-ce-19.2.0.1 /usr/lib/jvm
```

## Install the graalvm using the update-alternatives
```bash
update-alternatives --install /usr/bin/java java /usr/lib/jvm/graalvm-ce-19.2.0.1/bin/java 2
```

## Change the default java to graalvm java
```bash
 update-alternatives --config java
 ```

 ## make sure that java version displays graalvm
 ```bash
 java -version

openjdk version "1.8.0_222"
OpenJDK Runtime Environment (build 1.8.0_222-20190711120915.buildslave.jdk8u-src-tar--b08)
OpenJDK 64-Bit GraalVM CE 19.2.0.1 (build 25.222-b08-jvmci-19.2-b02, mixed mode)
```