# Подключение к топикам в кластере Apache Kafka^®^

Чтобы подключиться к кластеру {{ KF }}:

1. [Создайте учетные записи](cluster-accounts.md#create-account) для клиентов (производителей и потребителей) с доступами в нужные топики.
1. Убедитесь, что клиенты находятся в той же [виртуальной сети](../../vpc/concepts/network.md), что и кластер.
1. Подключите клиентов к кластеру:
   * производителей с помощью [Kafka Producer API](https://kafka.apache.org/documentation/#producerapi);
   * потребителей с помощью [Kafka Consumer API](https://kafka.apache.org/documentation/#consumerapi).

Для большинства популярных языков программирования существуют готовые реализации API {{ KF }}. Примеры кода для подключения к кластру приведены в разделе [{#T}](#connection-string).

## Примеры строк подключения {#connection-string}

{% list tabs %}

- Bash

   Для подлкючения к кластеру {{ KF }} из командной строки используйте утилиту kafkacat. kafkacat — это утилита с открытым исходным кодом, которая может работать как универсальный производитель или потребитель данных. Подробнее читайте в [документации](https://github.com/edenhill/kafkacat).
  
   1. Чтобы установить kafkacat, выполните команду:
   
      {% list tabs %}
      
      - Linux
      
         ```
         apt-get install kafkacat
         ```
      
      - macOS
         
         ```
         brew install kafkacat
         ```
            
      {% endlist %}
      
   1. Чтобы отправить сообщение в топик, выполните команду:
   
      ```bash
      echo "test message" | kafkacat -P  \
            -b <FQDN брокера> \
            -t <имя топика> \
            -X security.protocol=SASL_PLAINTEXT \
            -X sasl.mechanisms=SCRAM-SHA-512 \
            -X sasl.username=<логин производителя> \
            -X sasl.password=<пароль производителя> -Z -K:
      ```
   
   
   
   1. Чтобы получить сообщения из топика, выполните команду:
   
      ```bash
      kafkacat -C \
            -b <FQDN брокера> \
            -t <имя топика> \
            -X security.protocol=SASL_PLAINTEXT \
            -X sasl.mechanisms=SCRAM-SHA-512 \
            -X sasl.username=<логин потребителя> \
            -X sasl.password=<пароль потребителя>
      ```
   
   {% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}
  
- Python

   * Чтобы установаить Python-клиент API {{ KF }}, выполните команду:
   
      ```bash
      pip install kafka-python
      ```
   
   * Пример кода производителя данных:
   
      ```python
      from kafka import KafkaProducer
      
      producer = KafkaProducer(
          bootstrap_servers=<FQDN брокеров>,
          security_protocol="SASL_PLAINTEXT",
          sasl_mechanism="SCRAM-SHA-512",
          sasl_plain_password=<пароль производителя>,
          sasl_plain_username=<логин производителя>)
      ```
   
   * Пример кода потребителя данных:
   
      ```python
      from kafka import KafkaConsumer
      
      consumer = KafkaConsumer(
          bootstrap_servers=<FQDN брокеров>,
          security_protocol="SASL_PLAINTEXT",
          sasl_mechanism="SCRAM-SHA-512",
          sasl_plain_password=<пароль потребителя>,
          sasl_plain_username=<логин потребителя>)
      ```

   {% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

- Java
 
   * Чтобы установить Java-клиент API {{ KF }}, добавьте зависимости в Maven-проект:
   
      ```xml
      <dependency>
          <groupId>org.apache.kafka</groupId>
          <artifactId>kafka-clients</artifactId>
          <version>2.5.0</version>
      </dependency>
      ```
   
   * Пример кода производителя данных:
   
      ```java
      import org.apache.kafka.clients.producer.KafkaProducer;
      import org.apache.kafka.clients.producer.Producer;
      
      
      String jaasTemplate = "org.apache.kafka.common.security.scram.ScramLoginModule required username=\"%s\" password=\"%s\";";
      String jaasCfg = String.format(jaasTemplate, <логин производителя>, <пароль производителя>);
      
      String serializer = StringSerializer.class.getName();
      String deserializer = StringDeserializer.class.getName();
      Properties props = new Properties();
      props.put("bootstrap.servers", <FQDN брокеров>);
      props.put("acks", "all");
      props.put("auto.offset.reset", "earliest");
      props.put("key.deserializer", deserializer);
      props.put("value.deserializer", deserializer);
      props.put("key.serializer", serializer);
      props.put("value.serializer", serializer);
      props.put("security.protocol", "SASL_PLAINTEXT");
      props.put("sasl.mechanism", "SCRAM-SHA-512");
      props.put("sasl.jaas.config", jaasCfg);
      Producer<String, String> producer = new KafkaProducer<>(props);
      ```
   
   * Пример кода потребителя данных:
   
      ```java
      import org.apache.kafka.clients.consumer.KafkaConsumer;
      
      String jaasTemplate = "org.apache.kafka.common.security.scram.ScramLoginModule required username=\"%s\" password=\"%s\";";
      String jaasCfg = String.format(jaasTemplate, <логин потребителя>, <пароль потребителя>);
      
      String serializer = StringSerializer.class.getName();
      String deserializer = StringDeserializer.class.getName();
      Properties props = new Properties();
      props.put("bootstrap.servers", <FQDN брокеров>);
      props.put("auto.offset.reset", "earliest");
      props.put("key.deserializer", deserializer);
      props.put("value.deserializer", deserializer);
      props.put("key.serializer", serializer);
      props.put("value.serializer", serializer);
      props.put("security.protocol", "SASL_PLAINTEXT");
      props.put("sasl.mechanism", "SCRAM-SHA-512");
      props.put("sasl.jaas.config", jaasCfg);
      KafkaConsumer<String, String> consumer = new KafkaConsumer<>(props);
      consumer.subscribe(Arrays.asList(<topic>));
      ```

   {% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

- Go

   1. Чтобы установаить Go-клиент API {{ KF }}, выполните команду:
   
      ```shell
      go get github.com/Shopify/sarama
      ```
   
   1. Добавьте в ваши приложения общий код для использования [SCRAM](https://github.com/xdg-go/scram):
   
        ```go
      package main
   
      import (
      	"crypto/sha256"
      	"crypto/sha512"
      	"hash"
   
      	"github.com/xdg/scram"
      )
   
      var SHA256 scram.HashGeneratorFcn = func() hash.Hash { return sha256.New() }
      var SHA512 scram.HashGeneratorFcn = func() hash.Hash { return sha512.New() }
   
      type XDGSCRAMClient struct {
      	*scram.Client
      	*scram.ClientConversation
      	scram.HashGeneratorFcn
      }
   
      func (x *XDGSCRAMClient) Begin(userName, password, authzID string) (err error) {
      	x.Client, err = x.HashGeneratorFcn.NewClient(userName, password, authzID)
      	if err != nil {
      		return err
      	}
      	x.ClientConversation = x.Client.NewConversation()
      	return nil
      }
   
      func (x *XDGSCRAMClient) Step(challenge string) (response string, err error) {
      	response, err = x.ClientConversation.Step(challenge)
      	return
      }
   
      func (x *XDGSCRAMClient) Done() bool {
      	return x.ClientConversation.Done()
      }
      ```
   
   
   3. Пример кода производителя данных:
   
      ```go
      import (
      	"strings"
      
      	"github.com/Shopify/sarama"
      )
      
      brokers := <FQDN брокеров>
      splitBrokers := strings.Split(*brokers, ",")
      conf := sarama.NewConfig()
      conf.Producer.RequiredAcks = sarama.WaitForAll
      conf.Version = sarama.V0_10_0_0
      conf.ClientID = "sasl_scram_client"
      conf.Net.SASL.Enable = true
      conf.Net.SASL.Handshake = true
      conf.Net.SASL.User = <логин производителя>
      conf.Net.SASL.Password = <пароль производителя>
      conf.Net.SASL.SCRAMClientGeneratorFunc = func() sarama.SCRAMClient { return &XDGSCRAMClient{HashGeneratorFcn: SHA512} }
      conf.Net.SASL.Mechanism = sarama.SASLMechanism(sarama.SASLTypeSCRAMSHA512)
      syncProducer, err := sarama.NewSyncProducer(splitBrokers, conf)
      ```
   
   4. Пример кода потребителя данных:
   
      ```go
      import (
      	"strings"
      
      	"github.com/Shopify/sarama"
      )
      
      brokers := <FQDN брокеров>
      splitBrokers := strings.Split(*brokers, ",")
      conf := sarama.NewConfig()
      conf.Producer.RequiredAcks = sarama.WaitForAll
      conf.Version = sarama.V0_10_0_0
      conf.ClientID = "sasl_scram_client"
      conf.Metadata.Full = true
      conf.Net.SASL.Enable = true
      conf.Net.SASL.User = <логин потребителя>
      conf.Net.SASL.Password = <пароль потребителя>
      conf.Net.SASL.Handshake = true
      conf.Net.SASL.SCRAMClientGeneratorFunc = func() sarama.SCRAMClient { return &XDGSCRAMClient{HashGeneratorFcn: SHA512} }
      conf.Net.SASL.Mechanism = sarama.SASLMechanism(sarama.SASLTypeSCRAMSHA512)
      consumer, err := sarama.NewConsumer(splitBrokers, conf)
      ```

   {% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% endlist %}
