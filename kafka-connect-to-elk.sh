echo "install vim"
echo "------------"
docker exec --user="root" kafka bash -c "apt-get update & apt-get install vim"
echo ""
echo "copying some config files :"
echo "----------------------------"
docker exec kafka bash -c "/opt/bitnami/kafka/bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic yosi1"
docker cp kafka/kafka-connect/connectors/. kafka:/opt/bitnami/kafka/config
docker cp kafka/kafka-connect/lib/. kafka:/usr/local/share/kafka/plugins
docker cp kafka/hello.json /var/lib/kafka/.
docker exec kafka bash -c "sleep 5; /opt/bitnami/kafka/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic yosi1 < /var/lib/kafka/hello.json"
docker exec --user="root" kafka bash -c "/opt/bitnami/kafka/bin/connect-standalone.sh /opt/bitnami/kafka/config/connect-standalone.properties /opt/bitnami/kafka/config/elasticsearch-connect.properties"
echo ""
