/opt/bitnami/kafka/bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic elastic-test
/opt/bitnami/kafka/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic elastic-test < hello.json
