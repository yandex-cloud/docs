# Connecting to topics in an Apache Kafka® cluster

To connect to an {{ KF }} cluster:

1. [Create accounts](cluster-accounts.md#create-account) for clients (producers and consumers) with access to the necessary topics.
1. Make sure the clients are in the same [virtual network](../../vpc/concepts/network.md) as the cluster.
1. Connect the clients to the cluster:
   * Producers using the [Kafka Producer API](https://kafka.apache.org/documentation/#producerapi).
   * Consumers using the [Kafka Consumer API](https://kafka.apache.org/documentation/#consumerapi).

There are ready-made {{ KF }} API implementations for most popular programming languages. See code examples for connecting to a cluster in [{#T}](#connection-string).

## Sample connection strings {#connection-string}

{% list tabs %}

- Bash

   To connect to an {{ KF }} cluster from the command line, use kafkacat, an open source utility that can work as a universal data producer or consumer. Read more in the [documentation](https://github.com/edenhill/kafkacat).

   1. To install kafkacat, run the command:

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

   1. To send a message to a topic, run the command:

      ```bash
      echo "test message" | kafkacat -P  \
            -b <broker FQDN> \
            -t <topic name> \
            -X security.protocol=SASL_PLAINTEXT \
            -X sasl.mechanisms=SCRAM-SHA-512 \
            -X sasl.username=<producer username> \
            -X sasl.password=<producer password> -Z -K:
      ```

   1. To get messages from a topic, run the command:

      ```bash
      kafkacat -C \
            -b <broker FQDN> \
            -t <topic name> \
            -X security.protocol=SASL_PLAINTEXT \
            -X sasl.mechanisms=SCRAM-SHA-512 \
            -X sasl.username=<consumer username> \
            -X sasl.password=<consumer password>
      ```

   {% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

- Python

   * To install the Python client of the {{ KF }} API, run the command:

      ```bash
      pip install kafka-python
      ```

   * Sample data producer code:

      ```python
      from kafka import KafkaProducer
      
      producer = KafkaProducer(
          bootstrap_servers=<broker FQDN>,
          security_protocol="SASL_PLAINTEXT",
          sasl_mechanism="SCRAM-SHA-512",
          sasl_plain_password=<producer password>,
          sasl_plain_username=<producer username>)
      ```

   * Sample data consumer code:

      ```python
      from kafka import KafkaConsumer
      
      consumer = KafkaConsumer(
          bootstrap_servers=<broker FQDN>,
          security_protocol="SASL_PLAINTEXT",
          sasl_mechanism="SCRAM-SHA-512",
          sasl_plain_password=<consumer password>,
          sasl_plain_username=<consumer username>)
      ```

   {% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

- Java

   * To install the Java client of the {{ KF }} API, add dependencies to the Maven project:

      ```xml
      <dependency>
          <groupId>org.apache.kafka</groupId>
          <artifactId>kafka-clients</artifactId>
          <version>2.5.0</version>
      </dependency>
      ```

   * Sample data producer code:

      ```java
      import org.apache.kafka.clients.producer.KafkaProducer;
      import org.apache.kafka.clients.producer.Producer;
      
      
      String jaasTemplate = "org.apache.kafka.common.security.scram.ScramLoginModule required username=\"%s\" password=\"%s\";";
      String jaasCfg = String.format(jaasTemplate, <producer username>, <producer password>);
      
      String serializer = StringSerializer.class.getName();
      String deserializer = StringDeserializer.class.getName();
      Properties props = new Properties();
      props.put("bootstrap.servers", <broker FQDN>);
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

   * Sample data consumer code:

      ```java
      import org.apache.kafka.clients.consumer.KafkaConsumer;
      
      String jaasTemplate = "org.apache.kafka.common.security.scram.ScramLoginModule required username=\"%s\" password=\"%s\";";
       String jaasCfg = String.format(jaasTemplate, <consumer username>, <consumer password>);
      
      String serializer = StringSerializer.class.getName();
      String deserializer = StringDeserializer.class.getName();
      Properties props = new Properties();
      props.put("bootstrap.servers", <broker FQDN>);
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

   1. To install the Go client of the {{ KF }} API, run the command:

      ```shell
      go get github.com/Shopify/sarama
      ```

   1. Add to your applications common code to use [SCRAM](https://github.com/xdg-go/scram):

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

   3. Sample data producer code:

      ```go
      import (
      	"strings"
      
      	"github.com/Shopify/sarama"
      )
      
      brokers := <broker FQDN>
      splitBrokers := strings.Split(*brokers, ",")
      conf := sarama.NewConfig()
      conf.Producer.RequiredAcks = sarama.WaitForAll
      conf.Version = sarama.V0_10_0_0
      conf.ClientID = "sasl_scram_client"
      conf.Net.SASL.Enable = true
      conf.Net.SASL.Handshake = true
      conf.Net.SASL.User = <producer username>
      conf.Net.SASL.Password = <producer password>
      conf.Net.SASL.SCRAMClientGeneratorFunc = func() sarama.SCRAMClient { return &XDGSCRAMClient{HashGeneratorFcn: SHA512} }
      conf.Net.SASL.Mechanism = sarama.SASLMechanism(sarama.SASLTypeSCRAMSHA512)
      syncProducer, err := sarama.NewSyncProducer(splitBrokers, conf)
      ```

   4. Sample data consumer code:

      ```go
      import (
      	"strings"
      
      	"github.com/Shopify/sarama"
      )
      
      brokers := <broker FQDN>
      splitBrokers := strings.Split(*brokers, ",")
      conf := sarama.NewConfig()
      conf.Producer.RequiredAcks = sarama.WaitForAll
      conf.Version = sarama.V0_10_0_0
      conf.ClientID = "sasl_scram_client"
      conf.Metadata.Full = true
      conf.Net.SASL.Enable = true
      conf.Net.SASL.User = <consumer username>
      conf.Net.SASL.Password = <consumer password>
      conf.Net.SASL.Handshake = true
      conf.Net.SASL.SCRAMClientGeneratorFunc = func() sarama.SCRAMClient { return &XDGSCRAMClient{HashGeneratorFcn: SHA512} }
      conf.Net.SASL.Mechanism = sarama.SASLMechanism(sarama.SASLTypeSCRAMSHA512)
      consumer, err := sarama.NewConsumer(splitBrokers, conf)
      ```

   {% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% endlist %}
