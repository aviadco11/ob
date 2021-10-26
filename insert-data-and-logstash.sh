#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

echo "install vim"
echo "------------"
#docker exec --user="root" kafka bash -c "apt-get update & apt-get install vim"
echo ""
echo "insert data to mysql :"
echo "------------------------"
docker exec mysql bash -c " mysql -u root -p123 < /var/lib/mysql/insert-data-mysql.sql"
echo ""
echo "run logstash mysql to elasticsearch :"
echo "--------------------------------------"
docker exec logstash bash -c "/usr/share/logstash/bin/logstash --path.data sensor39 -f /var/lib/logstash/mysql-input.conf"
echo ""
echo "create topic in kafka :"
echo "------------------------"
docker exec kafka bash -c "/opt/bitnami/kafka/bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic elast-tst"
echo ""
echo "insert data to topic in kafka :"
echo "---------------------------------"
docker exec kafka bash -c "sleep 5; /opt/bitnami/kafka/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic elast-tst < /var/lib/kafka/hello.json"
echo ""
echo "run logstash kafka to elasticsearch :"
echo "----------------------------------------"
docker exec logstash bash -c "/usr/share/logstash/bin/logstash --path.data sensor44 -f /var/lib/logstash/kafka-input.conf"
