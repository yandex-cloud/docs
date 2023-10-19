Yandex Data Streams supports limited operations with data streams via the [Apache Kafka®](https://kafka.apache.org/) protocol. You can see the endpoints for Kafka API access on the Overview pages for the database and stream. First, request access to the Kafka API on these pages.

Authentication is based on the service account API key (provide it as your password).

To write data via the Kafka API, the service account must be assigned the following roles:
- ydb.editor
- ydb.kafkaApi.client

{% cut "Sample data write via the Kafka Java SDK" %}

```java
 String HOST = "ydb:9093";
 String TOPIC = "/Root/Database/Topic";
 String USER = "@/Root/Database";
 String PASS = "*****";  // Service account ApiKey

 Properties props = new Properties();
 props.put("bootstrap.servers", HOST);
 props.put("acks", "all");

 props.put("key.serializer", StringSerializer.class.getName());
 props.put("key.deserializer", StringDeserializer.class.getName());
 props.put("value.serializer", StringSerializer.class.getName());
 props.put("value.deserializer", StringDeserializer.class.getName());

 props.put("security.protocol", "SASL_PLAINTEXT");
 props.put("sasl.mechanism", "PLAIN");
 props.put("sasl.jaas.config", PlainLoginModule.class.getName() + " required username=\"" + USER + "\" password=\"" + PASS + "\";");

 props.put("compression.type", "none");

 Producer<String, String> producer = new KafkaProducer<>(props);
 producer.send(new ProducerRecord<String, String>(TOPIC, "msg-key", "msg-body"));
 producer.flush();
 producer.close();
```

{% endcut %}

For basic information on how to use Yandex Data Streams through the Kafka API, see the [YDB documentation](https://ydb.tech/en/docs/reference/kafka-api).
