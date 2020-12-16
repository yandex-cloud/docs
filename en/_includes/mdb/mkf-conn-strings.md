{% list tabs %}

- Bash

  To connect to an {{ KF }} cluster from the command line, use `kafkacat`, an open source application that can work as a universal data producer or consumer. Read more in the [documentation](https://github.com/edenhill/kafkacat).

  **Before connecting, install the dependencies:**

  ```bash
  sudo apt update && sudo apt install -y kafkacat
  ```

  **To send a message to a topic, run the command:**

  ```bash
  echo "test message" | kafkacat -P  \
         -b <FQDN of the broker>:9092 \
         -t <topic name> \
         -k key \
         -X security.protocol=SASL_PLAINTEXT \
         -X sasl.mechanisms=SCRAM-SHA-512 \
         -X sasl.username=<producer username> \
         -X sasl.password=<producer password> -Z
  ```

  **To get messages from a topic, run the command:**

  ```bash
  kafkacat -C \
          -b <FQDN of the broker>:9092 \
          -t <topic name> \
          -X security.protocol=SASL_PLAINTEXT \
          -X sasl.mechanisms=SCRAM-SHA-512 \
          -X sasl.username=<consumer username> \
          -X sasl.password=<consumer password> -Z -K:
  ```

- Bash (SSL)

  To connect to an {{ KF }} cluster from the command line, use `kafkacat`, an open source application that can work as a universal data producer or consumer. Read more in the [documentation](https://github.com/edenhill/kafkacat).

  **Before connecting, install the dependencies:**

  ```bash
  sudo apt update && sudo apt install -y kafkacat
  ```

  **To send a message to a topic, run the command:**

  ```bash
  echo "test message" | kafkacat -P  \
      -b <broker FQDN>:9091 \
      -t <topic name> \
      -k key \
      -X security.protocol=SASL_SSL \
      -X sasl.mechanisms=SCRAM-SHA-512 \
      -X sasl.username=<producer username> \
      -X sasl.password=<producer password> \
      -X ssl.ca.location=/usr/local/share/ca-certificates/Yandex/YandexCA.crt -Z   
  ```

  **To get messages from a topic, run the command:**

  ```bash
  kafkacat -C  \
      -b <broker FQDN>:9091 \
      -t <topic name> \
      -X security.protocol=SASL_SSL \
      -X sasl.mechanisms=SCRAM-SHA-512 \
      -X sasl.username=<consumer username> \
      -X sasl.password=<consumer password> \
      -X ssl.ca.location=/usr/local/share/ca-certificates/Yandex/YandexCA.crt -Z -K:   
  ```

- Python

  **Before connecting, install the dependencies:**

  ```bash
  sudo apt update && sudo apt install -y python3 python3-pip libsnappy-dev && \
  pip3 install kafka-python lz4 python-snappy crc32c
  ```

  **Example code for delivering a message to a topic:**

  `producer.py`

  ```python
  from kafka import KafkaProducer
  
  producer = KafkaProducer(
    bootstrap_servers='<FQDN of the broker host>:9092',
    security_protocol="SASL_PLAINTEXT",
    sasl_mechanism="SCRAM-SHA-512",
    sasl_plain_password='<producer password>',
    sasl_plain_username='<producer username>')
  
  producer.send('<topic name>', b'test message', b'key')
  producer.flush()
  producer.close()
  ```

  **Code example for getting messages from a topic:**

  `consumer.py`

  ```python
  from kafka import KafkaConsumer
  
  consumer = KafkaConsumer('<topic name>',
    bootstrap_servers='<FQDN of the broker>:9092',
    security_protocol="SASL_PLAINTEXT",
    sasl_mechanism="SCRAM-SHA-512",
    sasl_plain_password='<consumer password>',
    sasl_plain_username='<consumer name>')
  
  print("ready")
  
  for msg in consumer:
    print(msg.key.decode("utf-8") + ":" + msg.value.decode("utf-8"))
  ```

  **Running applications:**

  ```bash
  python3 producer.py
  ```

  ```bash
  python3 consumer.py
  ```

- Python (SSL)

  **Before connecting, install the dependencies:**

  ```bash
  sudo apt update && sudo apt install -y python3 python3-pip libsnappy-dev && \
  pip3 install kafka-python lz4 python-snappy crc32c
  ```

  **Example code for delivering a message to a topic:**

  `producer.py`

  ```python
  from kafka import KafkaProducer
  
  producer = KafkaProducer(
    bootstrap_servers='<FQDN of the broker host>:9091',
    security_protocol="SASL_SSL",
    sasl_mechanism="SCRAM-SHA-512",
    sasl_plain_password='<producer password>',
    sasl_plain_username='<producer username>',
    ssl_cafile="/usr/local/share/ca-certificates/Yandex/YandexCA.crt")
  
  producer.send('<topic name>', b'test message', b'key')
  producer.flush()
  producer.close()
  ```

  **Code example for getting messages from a topic:**

  `consumer.py`

  ```python
  from kafka import KafkaConsumer
  
  consumer = KafkaConsumer('<topic name>',
    bootstrap_servers='<FQDN of the broker>:9091',
    security_protocol="SASL_SSL",
    sasl_mechanism="SCRAM-SHA-512",
    sasl_plain_password='<consumer password>',
    sasl_plain_username='<consumer name>',
    ssl_cafile="/usr/local/share/ca-certificates/Yandex/YandexCA.crt")
  
  print("ready")
  
  for msg in consumer:
    print(msg.key.decode("utf-8") + ":" + msg.value.decode("utf-8"))
  ```

  **Running applications:**

  ```bash
  python3 producer.py
  ```

  ```bash
  python3 consumer.py
  ```

- Java

  **Before connecting:**

  1. Install the dependencies:

     ```bash
     sudo apt update && sudo apt install -y default-jdk maven
     ```

  1. Create a folder for the Maven project:

     ```bash
     cd ~/ && mkdir project && cd project && mkdir -p consumer/src/java/com/example producer/src/java/com/example && cd ~/project
     ```

  1. Create a configuration file for Maven:

     {% cut "pom.xml" %}

     ```xml
     <?xml version="1.0" encoding="UTF-8"?>
     <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
         <modelVersion>4.0.0</modelVersion>
         <groupId>com.example</groupId>
         <artifactId>app</artifactId>
         <packaging>jar</packaging>
         <version>0.1.0</version>
         <properties>
             <maven.compiler.source>1.8</maven.compiler.source>
             <maven.compiler.target>1.8</maven.compiler.target>
         </properties>
         <dependencies>
             <dependency>
                 <groupId>org.slf4j</groupId>
                 <artifactId>slf4j-simple</artifactId>
                 <version>1.7.30</version>
             </dependency>
             <dependency>
                 <groupId>com.fasterxml.jackson.core</groupId>
                 <artifactId>jackson-databind</artifactId>
                 <version>2.11.2</version>
             </dependency>
             <dependency>
                 <groupId>org.apache.kafka</groupId>
                 <artifactId>kafka-clients</artifactId>
                 <version>2.6.0</version>
             </dependency>
         </dependencies>
         <build>
             <finalName>${project.artifactId}-${project.version}</finalName>
             <sourceDirectory>src</sourceDirectory>
             <resources>
                 <resource>
                     <directory>src</directory>
                 </resource>
             </resources>
             <plugins>
                 <plugin>
                     <groupId>org.apache.maven.plugins</groupId>
                     <artifactId>maven-assembly-plugin</artifactId>
                     <executions>
                         <execution>
                             <goals>
                                 <goal>attached</goal>
                             </goals>
                             <phase>package</phase>
                             <configuration>
                                 <descriptorRefs>
                                     <descriptorRef>jar-with-dependencies</descriptorRef>
                                 </descriptorRefs>
                                 <archive>
                                     <manifest>
                                         <mainClass>com.example.App</mainClass>
                                     </manifest>
                                 </archive>
                             </configuration>
                         </execution>
                     </executions>
                 </plugin>
                 <plugin>
                     <groupId>org.apache.maven.plugins</groupId>
                     <artifactId>maven-jar-plugin</artifactId>
                     <version>3.1.0</version>
                     <configuration>
                         <archive>
                             <manifest>
                                 <mainClass>com.example.App</mainClass>
                             </manifest>
                         </archive>
                     </configuration>
                 </plugin>
             </plugins>
         </build>
     </project>
     ```

     {% endcut %}

     Up-to-date versions of dependencies for Maven:
     - [kafka-clients](https://mvnrepository.com/artifact/org.apache.kafka/kafka-clients).
     - [jackson-databind](https://mvnrepository.com/artifact/com.fasterxml.jackson.core/jackson-databind).
     - [slf4j-simple](https://mvnrepository.com/artifact/org.slf4j/slf4j-simple).

   1. Copy `pom.xml` to the directories of the producer application and consumer application:

      ```bash
      cp pom.xml producer/pom.xml && cp pom.xml consumer/pom.xml
      ```

  **Example code for delivering messages to a topic:**

  `producer/src/java/com/example/App.java`

  ```java
  package com.example;
  
  import java.util.*;
  import org.apache.kafka.common.*;
  import org.apache.kafka.common.serialization.StringSerializer;
  import org.apache.kafka.clients.producer.*;
  
  public class App {
  
    public static void main(String[] args) {
  
      int MSG_COUNT = 5;
  
      String HOST = "<FQDN of the broker>:9092";
      String TOPIC = "<topic name>";
      String USER = "<producer name>";
      String PASS = "<producer password>";
  
      String jaasTemplate = "org.apache.kafka.common.security.scram.ScramLoginModule required username=\"%s\" password=\"%s\";";
      String jaasCfg = String.format(jaasTemplate, USER, PASS);
      String KEY = "key";
  
      String serializer = StringSerializer.class.getName();
      Properties props = new Properties();
      props.put("bootstrap.servers", HOST);
      props.put("acks", "all");
      props.put("key.serializer", serializer);
      props.put("value.serializer", serializer);
      props.put("security.protocol", "SASL_PLAINTEXT");
      props.put("sasl.mechanism", "SCRAM-SHA-512");
      props.put("sasl.jaas.config", jaasCfg);
  
      Producer<String, String> producer = new KafkaProducer<>(props);
  
      try {
       for (int i = 1; i <= MSG_COUNT; i++){
         producer.send(new ProducerRecord<String, String>(TOPIC, KEY, "test message")).get();
         System.out.println("Test message " + i);
        }
       producer.flush();
       producer.close();
      } catch (Exception ex) {
          System.out.println(ex);
          producer.close();
      }
    }
  }
  ```

  **Code example for getting messages from a topic:**

  `consumer/src/java/com/example/App.java`

  ```java
  package com.example;
  
  import java.util.*;
  import org.apache.kafka.common.*;
  import org.apache.kafka.common.serialization.StringDeserializer;
  import org.apache.kafka.clients.consumer.*;
  
  public class App {
  
    public static void main(String[] args) {
  
      String HOST = "<FQDN of the broker>:9092";
      String TOPIC = "<topic name>";
      String USER = "<consumer name>";
      String PASS = "<consumer password>";
  
      String jaasTemplate = "org.apache.kafka.common.security.scram.ScramLoginModule required username=\"%s\" password=\"%s\";";
      String jaasCfg = String.format(jaasTemplate, USER, PASS);
      String GROUP = "demo";
  
      String deserializer = StringDeserializer.class.getName();
      Properties props = new Properties();
      props.put("bootstrap.servers", HOST);
      props.put(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "earliest");
      props.put("group.id", GROUP);
      props.put("key.deserializer", deserializer);
      props.put("value.deserializer", deserializer);
      props.put("security.protocol", "SASL_PLAINTEXT");
      props.put("sasl.mechanism", "SCRAM-SHA-512");
      props.put("sasl.jaas.config", jaasCfg);
  
      Consumer<String, String> consumer = new KafkaConsumer<>(props);
      consumer.subscribe(Arrays.asList(new String[] {TOPIC}));
  
      while(true) {
        ConsumerRecords<String, String> records = consumer.poll(100);
        for (ConsumerRecord<String, String> record : records) {
          System.out.println(record.key() + ":" + record.value());
        }
      }
    }
  }
  ```

  **Building applications:**

  ```bash
  cd ~/project/producer && mvn clean package && \
  cd ~/project/consumer && mvn clean package 
  ```

  **Running applications:**

  ```bash
  java -jar ~/project/producer/target/app-0.1.0-jar-with-dependencies.jar
  ```

  ```bash
  java -jar ~/project/consumer/target/app-0.1.0-jar-with-dependencies.jar
  ```

- Java (SSL)

  **Before connecting:**

  1. Install the dependencies:

     ```bash
     sudo apt update && sudo apt install -y default-jdk maven
     ```

  1. Add the SSL certificate to the Java trusted certificate store (Java Key Store) so that the {{ KF }} driver can use this certificate for secure connections to the cluster hosts. Make sure to set the password using the `-storepass` parameter for additional storage protection:

     ```bash
     cd /etc/security && \
     sudo keytool -importcert -alias YandexCA -file /usr/local/share/ca-certificates/Yandex/YandexCA.crt \
            -keystore ssl -storepass <certificate store password> \
            --noprompt
     ```

  1. Create a folder for the Maven project:

     ```bash
     cd ~/ && mkdir project && cd project && mkdir -p consumer/src/java/com/example producer/src/java/com/example && cd ~/project
     ```

  1. Create a configuration file for Maven:

     {% cut "pom.xml" %}

     ```xml
     <?xml version="1.0" encoding="UTF-8"?>
     <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
         <modelVersion>4.0.0</modelVersion>
         <groupId>com.example</groupId>
         <artifactId>app</artifactId>
         <packaging>jar</packaging>
         <version>0.1.0</version>
         <properties>
             <maven.compiler.source>1.8</maven.compiler.source>
             <maven.compiler.target>1.8</maven.compiler.target>
         </properties>
         <dependencies>
             <dependency>
                 <groupId>org.slf4j</groupId>
                 <artifactId>slf4j-simple</artifactId>
                 <version>1.7.30</version>
             </dependency>
             <dependency>
                 <groupId>com.fasterxml.jackson.core</groupId>
                 <artifactId>jackson-databind</artifactId>
                 <version>2.11.2</version>
             </dependency>
             <dependency>
                 <groupId>org.apache.kafka</groupId>
                 <artifactId>kafka-clients</artifactId>
                 <version>2.6.0</version>
             </dependency>
         </dependencies>
         <build>
             <finalName>${project.artifactId}-${project.version}</finalName>
             <sourceDirectory>src</sourceDirectory>
             <resources>
                 <resource>
                     <directory>src</directory>
                 </resource>
             </resources>
             <plugins>
                 <plugin>
                     <groupId>org.apache.maven.plugins</groupId>
                     <artifactId>maven-assembly-plugin</artifactId>
                     <executions>
                         <execution>
                             <goals>
                                 <goal>attached</goal>
                             </goals>
                             <phase>package</phase>
                             <configuration>
                                 <descriptorRefs>
                                     <descriptorRef>jar-with-dependencies</descriptorRef>
                                 </descriptorRefs>
                                 <archive>
                                     <manifest>
                                         <mainClass>com.example.App</mainClass>
                                     </manifest>
                                 </archive>
                             </configuration>
                         </execution>
                     </executions>
                 </plugin>
                 <plugin>
                     <groupId>org.apache.maven.plugins</groupId>
                     <artifactId>maven-jar-plugin</artifactId>
                     <version>3.1.0</version>
                     <configuration>
                         <archive>
                             <manifest>
                                 <mainClass>com.example.App</mainClass>
                             </manifest>
                         </archive>
                     </configuration>
                 </plugin>
             </plugins>
         </build>
     </project>
     ```

     {% endcut %}

     Up-to-date versions of dependencies for Maven:
     - [kafka-clients](https://mvnrepository.com/artifact/org.apache.kafka/kafka-clients);
     - [jackson-databind](https://mvnrepository.com/artifact/com.fasterxml.jackson.core/jackson-databind);
     - [slf4j-simple](https://mvnrepository.com/artifact/org.slf4j/slf4j-simple).

   1. Copy `pom.xml` to the directories of the producer application and consumer application:

      ```bash
      cp pom.xml producer/pom.xml && cp pom.xml consumer/pom.xml
      ```

  **Example code for delivering messages to a topic:**

  `producer/src/java/com/example/App.java`

  ```java
  package com.example;
  
  import java.util.*;
  import org.apache.kafka.common.*;
  import org.apache.kafka.common.serialization.StringSerializer;
  import org.apache.kafka.clients.producer.*;
  
  public class App {
  
    public static void main(String[] args) {
  
      int MSG_COUNT = 5;
  
      String HOST = "<FQDN of the broker>:9091";
      String TOPIC = "<topic name>";
      String USER = "<producer name>";
      String PASS = "<producer password>";
      String TS_FILE = "/etc/security/ssl";
      String TS_PASS = "<certificate store password>";
  
      String jaasTemplate = "org.apache.kafka.common.security.scram.ScramLoginModule required username=\"%s\" password=\"%s\";";
      String jaasCfg = String.format(jaasTemplate, USER, PASS);
      String KEY = "key";
  
      String serializer = StringSerializer.class.getName();
      Properties props = new Properties();
      props.put("bootstrap.servers", HOST);
      props.put("acks", "all");
      props.put("key.serializer", serializer);
      props.put("value.serializer", serializer);
      props.put("security.protocol", "SASL_SSL");
      props.put("sasl.mechanism", "SCRAM-SHA-512");
      props.put("sasl.jaas.config", jaasCfg);
      props.put("ssl.truststore.location", TS_FILE);
      props.put("ssl.truststore.password", TS_PASS);
  
      Producer<String, String> producer = new KafkaProducer<>(props);
  
      try {
       for (int i = 1; i <= MSG_COUNT; i++){
         producer.send(new ProducerRecord<String, String>(TOPIC, KEY, "test message")).get();
         System.out.println("Test message " + i);
        }
       producer.flush();
       producer.close();
      } catch (Exception ex) {
          System.out.println(ex);
          producer.close();
      }
    }
  }
  ```

  **Code example for getting messages from a topic:**

  `consumer/src/java/com/example/App.java`

  ```java
  package com.example;
  
  import java.util.*;
  import org.apache.kafka.common.*;
  import org.apache.kafka.common.serialization.StringDeserializer;
  import org.apache.kafka.clients.consumer.*;
  
  public class App {
  
    public static void main(String[] args) {
  
      String HOST = "<FQDN of the broker>:9091";
      String TOPIC = "<topic name>";
      String USER = "<consumer name>";
      String PASS = "<consumer password>";
      String TS_FILE = "/etc/security/ssl"; 
      String TS_PASS = "<certificate store password>";
  
      String jaasTemplate = "org.apache.kafka.common.security.scram.ScramLoginModule required username=\"%s\" password=\"%s\";";
      String jaasCfg = String.format(jaasTemplate, USER, PASS);
      String GROUP = "demo";
  
      String deserializer = StringDeserializer.class.getName();
      Properties props = new Properties();
      props.put("bootstrap.servers", HOST);
      props.put(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "earliest");
      props.put("group.id", GROUP);
      props.put("key.deserializer", deserializer);
      props.put("value.deserializer", deserializer);
      props.put("security.protocol", "SASL_SSL");
      props.put("sasl.mechanism", "SCRAM-SHA-512");
      props.put("sasl.jaas.config", jaasCfg);
      props.put("ssl.truststore.location", TS_FILE);
      props.put("ssl.truststore.password", TS_PASS);
  
      Consumer<String, String> consumer = new KafkaConsumer<>(props);
      consumer.subscribe(Arrays.asList(new String[] {TOPIC}));
  
      while(true) {
        ConsumerRecords<String, String> records = consumer.poll(100);
        for (ConsumerRecord<String, String> record : records) {
          System.out.println(record.key() + ":" + record.value());
        }
      }
    }
  }
  ```

  **Building applications:**

  ```bash
  cd ~/project/producer && mvn clean package && \
  cd ~/project/consumer && mvn clean package 
  ```

  **Running applications:**

  ```bash
  java -jar ~/project/producer/target/app-0.1.0-jar-with-dependencies.jar
  ```

  ```bash
  java -jar ~/project/consumer/target/app-0.1.0-jar-with-dependencies.jar
  ```

- Go

  **Before connecting:**

  1. Install the dependencies:

     ```bash
     sudo apt update && sudo apt install -y golang git && \
     go get github.com/Shopify/sarama && \
     go get github.com/xdg/scram
     ```

  1. Create a directory for the project:

     ```bash
     cd ~/ && mkdir go-project && cd go-project && mkdir -p consumer producer
     ```

  1. Create the `scram.go` file with the code for running [SCRAM](https://github.com/xdg-go/scram). This code is the same for the producer application and consumer application:

     {% cut "scram.go" %}

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

     {% endcut %}

  1. Copy `scram.go` to the directory of the producer application and the consumer application:

     ```bash
     cp scram.go producer/scram.go && cp scram.go consumer/scram.go
     ```

  **Example code for delivering a message to a topic:**

  `producer/main.go`

  ```go
  package main
  
  import (
        "fmt"
        "os"
        "strings"
  
        "github.com/Shopify/sarama"
  )
  
  func main() {
        brokers := "<FQDN of the broker host>:9092"
        splitBrokers := strings.Split(brokers, ",")
        conf := sarama.NewConfig()
        conf.Producer.RequiredAcks = sarama.WaitForAll
        conf.Producer.Return.Successes = true
        conf.Version = sarama.V0_10_0_0
        conf.ClientID = "sasl_scram_client"
        conf.Net.SASL.Enable = true
        conf.Net.SASL.Handshake = true
        conf.Net.SASL.User = "<producer username>"
        conf.Net.SASL.Password = "<producer password>"
        conf.Net.SASL.SCRAMClientGeneratorFunc = func() sarama.SCRAMClient { return &XDGSCRAMClient{HashGeneratorFcn: SHA512} }
        conf.Net.SASL.Mechanism = sarama.SASLMechanism(sarama.SASLTypeSCRAMSHA512)
  
        syncProducer, err := sarama.NewSyncProducer(splitBrokers, conf)
        if err != nil {
                fmt.Println("Couldn't create producer: ", err.Error())
                os.Exit(0)
        }
        publish("test message", syncProducer)
  
  }
  
  func publish(message string, producer sarama.SyncProducer) {
    // publish sync
    msg := &sarama.ProducerMessage {
        Topic: "<topic name>",
        Value: sarama.StringEncoder(message),
    }
    p, o, err := producer.SendMessage(msg)
    if err != nil {
        fmt.Println("Error publish: ", err.Error())
    }
  
    fmt.Println("Partition: ", p)
    fmt.Println("Offset: ", o)
  }
  ```

  **Code example for getting messages from a topic:**

  `consumer/main.go`

  ```go
  package main
  
  import (
        "fmt"
        "os"
        "os/signal"
        "strings"
  
        "github.com/Shopify/sarama"
  )
  
  func main() {
        brokers := "<FQDN of the broker host>:9092"
        splitBrokers := strings.Split(brokers, ",")
        conf := sarama.NewConfig()
        conf.Producer.RequiredAcks = sarama.WaitForAll
        conf.Version = sarama.V0_10_0_0
        conf.Consumer.Return.Errors = true
        conf.ClientID = "sasl_scram_client"
        conf.Metadata.Full = true
        conf.Net.SASL.Enable = true
        conf.Net.SASL.User =  "<consumer name>"
        conf.Net.SASL.Password = "<consumer password>"
        conf.Net.SASL.Handshake = true
        conf.Net.SASL.SCRAMClientGeneratorFunc = func() sarama.SCRAMClient { return &XDGSCRAMClient{HashGeneratorFcn: SHA512} }
        conf.Net.SASL.Mechanism = sarama.SASLMechanism(sarama.SASLTypeSCRAMSHA512)
  
        master, err := sarama.NewConsumer(splitBrokers, conf)
        if err != nil {
                fmt.Println("Coulnd't create consumer: ", err.Error())
                os.Exit(1)
        }
  
        defer func() {
                if err := master.Close(); err != nil {
                        panic(err)
                }
        }()
  
        topic := "<topic name>"
  
        consumer, err := master.ConsumePartition(topic, 0, sarama.OffsetOldest)
        if err != nil {
                panic(err)
        }
  
        signals := make(chan os.Signal, 1)
        signal.Notify(signals, os.Interrupt)
  
        // Count how many message processed
        msgCount := 0
  
        // Get signal for finish
        doneCh := make(chan struct{})
        go func() {
                for {
                        select {
                        case err := <-consumer.Errors():
                                fmt.Println(err)
                        case msg := <-consumer.Messages():
                                msgCount++
                                fmt.Println("Received messages", string(msg.Key), string(msg.Value))
                        case <-signals:
                                fmt.Println("Interrupt is detected")
                                doneCh <- struct{}{}
                        }
                }
        }()
  
        <-doneCh
        fmt.Println("Processed", msgCount, "messages")
  }
  ```

  **Building applications:**

  ```bash
  cd ~/go-project/producer && go build && \
  cd ~/go-project/consumer && go build 
  ```

  **Running applications:**

  ```bash
  ~/go-project/producer/producer
  ```

  ```bash
  ~/go-project/consumer/consumer
  ```

- Go (SSL)

  **Before connecting:**

  1. Install the dependencies:

     ```bash
     sudo apt update && sudo apt install -y golang git && \
     go get github.com/Shopify/sarama && \
     go get github.com/xdg/scram
     ```

  1. Create a directory for the project:

     ```bash
     cd ~/ && mkdir go-project && cd go-project && mkdir -p consumer producer
     ```

  1. Create the `scram.go` file with the code for running [SCRAM](https://github.com/xdg-go/scram). This code is the same for the producer application and consumer application:

     {% cut "scram.go" %}

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

     {% endcut %}

  1. Copy `scram.go` to the directory of the producer application and the consumer application:

     ```bash
     cp scram.go producer/scram.go && cp scram.go consumer/scram.go
     ```

  **Example code for delivering a message to a topic:**

  `producer/main.go`

  ```go
  package main
  
  import (
        "fmt"
        "crypto/tls"
        "crypto/x509"
        "io/ioutil"
        "os"
        "strings"
  
        "github.com/Shopify/sarama"
  )
  
  func main() {
        brokers := "<FQDN of the broker host>:9091"
        splitBrokers := strings.Split(brokers, ",")
        conf := sarama.NewConfig()
        conf.Producer.RequiredAcks = sarama.WaitForAll
        conf.Producer.Return.Successes = true
        conf.Version = sarama.V0_10_0_0
        conf.ClientID = "sasl_scram_client"
        conf.Net.SASL.Enable = true
        conf.Net.SASL.Handshake = true
        conf.Net.SASL.User = "<producer username>"
        conf.Net.SASL.Password = "<producer password>"
        conf.Net.SASL.SCRAMClientGeneratorFunc = func() sarama.SCRAMClient { return &XDGSCRAMClient{HashGeneratorFcn: SHA512} }
        conf.Net.SASL.Mechanism = sarama.SASLMechanism(sarama.SASLTypeSCRAMSHA512)
  
        certs := x509.NewCertPool()
        pemPath := "/usr/local/share/ca-certificates/Yandex/YandexCA.crt"
        pemData, err := ioutil.ReadFile(pemPath)
        if err != nil {
                fmt.Println("Couldn't load cert: ", err.Error())
            // handle the error
        }
        certs.AppendCertsFromPEM(pemData)
  
        conf.Net.TLS.Enable = true
        conf.Net.TLS.Config = &tls.Config{
          InsecureSkipVerify: true,
          RootCAs: certs,
        }
  
        syncProducer, err := sarama.NewSyncProducer(splitBrokers, conf)
        if err != nil {
                fmt.Println("Couldn't create producer: ", err.Error())
                os.Exit(0)
        }
        publish("test message", syncProducer)
  
  }
  
  func publish(message string, producer sarama.SyncProducer) {
    // publish sync
    msg := &sarama.ProducerMessage {
        Topic: "<topic name>",
        Value: sarama.StringEncoder(message),
    }
    p, o, err := producer.SendMessage(msg)
    if err != nil {
        fmt.Println("Error publish: ", err.Error())
    }
  
    fmt.Println("Partition: ", p)
    fmt.Println("Offset: ", o)
  }
  ```

  **Code example for getting messages from a topic:**

  `consumer/main.go`

  ```go
  package main
  
  import (
        "fmt"
        "crypto/tls"
        "crypto/x509"
        "io/ioutil"
        "os"
        "os/signal"
        "strings"
  
        "github.com/Shopify/sarama"
  )
  
  func main() {
        brokers := "<FQDN of the broker host>:9091"
        splitBrokers := strings.Split(brokers, ",")
        conf := sarama.NewConfig()
        conf.Producer.RequiredAcks = sarama.WaitForAll
        conf.Version = sarama.V0_10_0_0
        conf.Consumer.Return.Errors = true
        conf.ClientID = "sasl_scram_client"
        conf.Metadata.Full = true
        conf.Net.SASL.Enable = true
        conf.Net.SASL.User =  "<consumer name>"
        conf.Net.SASL.Password = "<consumer password>"
        conf.Net.SASL.Handshake = true
        conf.Net.SASL.SCRAMClientGeneratorFunc = func() sarama.SCRAMClient { return &XDGSCRAMClient{HashGeneratorFcn: SHA512} }
        conf.Net.SASL.Mechanism = sarama.SASLMechanism(sarama.SASLTypeSCRAMSHA512)
  
        certs := x509.NewCertPool()
        pemPath := "/usr/local/share/ca-certificates/Yandex/YandexCA.crt"
        pemData, err := ioutil.ReadFile(pemPath)
        if err != nil {
            fmt.Println("Couldn't load cert: ", err.Error())
                // handle the error
        }
        certs.AppendCertsFromPEM(pemData)
  
        conf.Net.TLS.Enable = true
        conf.Net.TLS.Config = &tls.Config{
                  InsecureSkipVerify: true,
                    RootCAs: certs,
        }
  
        master, err := sarama.NewConsumer(splitBrokers, conf)
        if err != nil {
                fmt.Println("Coulnd't create consumer: ", err.Error())
                os.Exit(1)
        }
  
        defer func() {
                if err := master.Close(); err != nil {
                        panic(err)
                }
        }()
  
        topic := "<topic name>"
  
        consumer, err := master.ConsumePartition(topic, 0, sarama.OffsetOldest)
        if err != nil {
                panic(err)
        }
  
        signals := make(chan os.Signal, 1)
        signal.Notify(signals, os.Interrupt)
  
        // Count how many message processed
        msgCount := 0
  
        // Get signal for finish
        doneCh := make(chan struct{})
        go func() {
                for {
                        select {
                        case err := <-consumer.Errors():
                                fmt.Println(err)
                        case msg := <-consumer.Messages():
                                msgCount++
                                fmt.Println("Received messages", string(msg.Key), string(msg.Value))
                        case <-signals:
                                fmt.Println("Interrupt is detected")
                                doneCh <- struct{}{}
                        }
                }
        }()
  
        <-doneCh
        fmt.Println("Processed", msgCount, "messages")
  }
  ```

  **Building applications:**

  ```bash
  cd ~/go-project/producer && go build && \
  cd ~/go-project/consumer && go build 
  ```

  **Running applications:**

  ```bash
  ~/go-project/producer/producer
  ```

  ```bash
  ~/go-project/consumer/consumer
  ```

{% endlist %}

