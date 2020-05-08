# Below instructions will help us installing and getting started with Apache Kafka on Ubuntu 18.04

# update the system
apt-get update

# Install java 11
apt install default-jre -y

# Download kafka
wget https://downloads.apache.org/kafka/2.4.1/kafka_2.13-2.4.1.tgz

# Create a directory 
mkdir kafka

# Extract the contents to that directory
tar -xvzf kafka_2.13-2.4.1.tgz --strip 1

# Add the below line to file
vi config/server.properties

delete.topic.enable = true

# Open zookeeper file
vi /etc/systemd/system/zookeeper.service

# Add below contests to it

[Unit]
Requires=network.target remote-fs.target
After=network.target remote-fs.target

[Service]
Type=simple
User=root
ExecStart=/root/kafka/bin/zookeeper-server-start.sh /root/kafka/config/zookeeper.properties
ExecStop=/root/kafka/bin/zookeeper-server-stop.sh
Restart=on-abnormal

[Install]
WantedBy=multi-user.target


# Create a system unit file for kafka service
vi /etc/systemd/system/kafka.service

# Add below content to it
[Unit]
Requires=zookeeper.service
After=zookeeper.service

[Service]
Type=simple
User=root
ExecStart=/bin/sh -c '/root/kafka/bin/kafka-server-start.sh /root/kafka/config/server.properties > /root/kafka/kafka.log 2>&1'
ExecStop=/root/kafka/bin/kafka-server-stop.sh
Restart=on-abnormal

[Install]
WantedBy=multi-user.target


# Enable it to run on system boot
sudo systemctl enable kafka

# Start the kafka service
sudo systemctl start kafka

# To create a second broker
cp config/server.properties config/server.properties.2

# Change the broker id, port the log dir
broker.id=1
listeners=PLAINTEXT://localhost:9093
log.dirs=/tmp/kafka-logs-1


# Create a topic to test the installation
bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic FirstTopic

# or create topics with partitions
bin/kafka-topics.sh --create --bootstrap-server localhost:9093 --partitions 2 --replication-factor 2 --topic user-tracking

# Now list the topics
bin/kafka-topics.sh --list --zookeeper localhost:2181

# Produce a message now
bin/kafka-console-producer.sh --broker-list localhost:9092 --topic FirstTopic

# Keep the tab opened and create a new tab
# Now consume the message
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic FirstTopic --from-beginning


# Install kafkat
apt install ruby ruby-dev build-essential -y
gem install kafkat

# Add some config in file ~/.kafkatcfg
{
  "kafka_path": "/root/kafka",
  "log_path": "/var/log/kafka-logs",
  "zk_path": "localhost:2181"
}


# Display partitions
kafkat partitions
