Yandex Data Streams в ограниченном режиме поддерживает работу с потоками данных по протоколу [Apache Kafka®](https://kafka.apache.org/). Эндпоинты для доступа по Kafka API отображаются на страницах Обзора базы данных и Обзора потока.

Аутентификация осуществляется по ApiKey сервисного аккаунта (его следует передать в качестве пароля). 

Для записи через Kafka API cервисный аккаунт должен обладать ролями:
 - ydb.editor
 - ydb.kafkaApi.client

{% cut "Пример записи по Kafka Java SDK" %}

```java
 String HOST = "ydb:9093";
 String TOPIC = "/Root/Database/Topic";
 String USER = "@/Root/Database";
 String PASS = "*****";  // ApiKey сервисного аккаунта

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

Основную документацию по работе с Data Streams через Kafka API см. в [документации YDB](https://ydb.tech/ru/docs/reference/kafka-api).
