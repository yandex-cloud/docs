### Bash {#bash}

Для подключения к кластеру {{ KF }} из командной строки используйте утилиту `kafkacat` — приложение с открытым исходным кодом, которое может работать как универсальный производитель или потребитель данных. Подробнее читайте в [документации](https://github.com/edenhill/kafkacat).

Перед подключением установите зависимости:

```bash
sudo apt update && sudo apt install -y kafkacat
```

{% list tabs %}

- Подключение без SSL

  1. Запустите команду получения сообщений из топика:

      ```bash
      kafkacat -C \
               -b <FQDN_брокера>:9092 \
               -t <имя_топика> \
               -X security.protocol=SASL_PLAINTEXT \
               -X sasl.mechanism=SCRAM-SHA-512 \
               -X sasl.username="<логин_потребителя>" \
               -X sasl.password="<пароль_потребителя>" -Z
      ```

     Команда будет непрерывно считывать новые сообщения из топика.

  1. В отдельном терминале запустите команду отправки сообщения в топик:

      ```bash
      echo "test message" | kafkacat -P \
             -b <FQDN_брокера>:9092 \
             -t <имя_топика> \
             -k key \
             -X security.protocol=SASL_PLAINTEXT \
             -X sasl.mechanism=SCRAM-SHA-512 \
             -X sasl.username="<логин_производителя>" \
             -X sasl.password="<пароль_производителя>" -Z
      ```

- Подключение с SSL

    1. Запустите команду получения сообщений из топика:

        {% include [default-get-string](./mkf/default-get-string.md) %}

       Команда будет непрерывно считывать новые сообщения из топика.

    1. В отдельном терминале запустите команду отправки сообщения в топик:

        {% include [default-get-string](./mkf/default-send-string.md) %}

{% endlist %}

{% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

{% include [shell-howto](../../_includes/mdb/mkf/connstr-shell-howto.md) %}

### C# {#csharp}

Перед подключением:

1. Установите зависимости:

    ```bash
    wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    sudo dpkg -i packages-microsoft-prod.deb && \
    sudo apt-get update && \
    sudo apt-get install -y apt-transport-https dotnet-sdk-5.0
    ```

1. Создайте директорию для проекта:

    ```bash
    cd ~/ && mkdir cs-project && cd cs-project && mkdir -p consumer producer && cd ~/cs-project
    ```

1. Создайте конфигурационный файл:

    `App.csproj`

    ```xml
    <Project Sdk="Microsoft.NET.Sdk">
      <PropertyGroup>
        <OutputType>Exe</OutputType>
        <TargetFramework>netcoreapp5.0</TargetFramework>
      </PropertyGroup>

      <ItemGroup>
        <PackageReference Include="Confluent.Kafka" Version="1.4.2" />
      </ItemGroup>
    </Project>
    ```

1. Скопируйте `App.csproj` в директории приложения-производителя и приложения-потребителя:

    ```bash
    cp App.csproj producer/App.csproj && cp App.csproj consumer/App.csproj
    ```

{% list tabs %}

- Подключение без SSL

    1. Пример кода для отправки сообщений в топик:

        `cs-project/producer/Program.cs`

        ```csharp
        using Confluent.Kafka;
        using System;
        using System.Collections.Generic;

        namespace App
        {
            class Program
            {
                public static void Main(string[] args)
                {
                    int MSG_COUNT = 5;

                    string HOST = "<FQDN_хоста-брокера>:9092";
                    string TOPIC = "<имя_топика>";
                    string USER = "<имя_производителя>";
                    string PASS = "<пароль_производителя>";

                    var producerConfig = new ProducerConfig(
                        new Dictionary<string,string>{
                            {"bootstrap.servers", HOST},
                            {"security.protocol", "SASL_PLAINTEXT"},
                            {"sasl.mechanism", "SCRAM-SHA-512"},
                            {"sasl.username", USER},
                            {"sasl.password", PASS}
                        }
                    );

                    var producer = new ProducerBuilder<string, string>(producerConfig).Build();

                    for(int i=0; i<MSG_COUNT; i++)
                    {
                        producer.Produce(TOPIC, new Message<string, string> { Key = "key", Value = "test message" },
                        (deliveryReport) =>
                        {
                            if (deliveryReport.Error.Code != ErrorCode.NoError)
                            {
                                Console.WriteLine($"Failed to deliver message: {deliveryReport.Error.Reason}");
                            }
                            else
                            {
                            Console.WriteLine($"Produced message to: {deliveryReport.TopicPartitionOffset}");
                            }
                        });
                    }
                    producer.Flush(TimeSpan.FromSeconds(10));
                }
            }
        }
        ```

    1. Пример кода для получения сообщений из топика:

        `cs-project/consumer/Program.cs`

        ```csharp
        using Confluent.Kafka;
        using System;
        using System.Collections.Generic;

        namespace CCloud
        {
            class Program
            {
                public static void Main(string[] args)
                {
                    string HOST = "<FQDN_хоста-брокера>:9092";
                    string TOPIC = "<имя_топика>";
                    string USER = "<имя_потребителя>";
                    string PASS = "<пароль_потребителя>";

                    var consumerConfig = new ConsumerConfig(
                        new Dictionary<string,string>{
                            {"bootstrap.servers", HOST},
                            {"security.protocol", "SASL_PLAINTEXT"},
                            {"sasl.mechanism", "SCRAM-SHA-512"},
                            {"sasl.username", USER},
                            {"sasl.password", PASS},
                            {"group.id", "demo"}
                        }
                    );

                    var consumer = new ConsumerBuilder<string, string>(consumerConfig).Build();
                    consumer.Subscribe(TOPIC);
                    try
                    {
                        while (true)
                        {
                            var cr = consumer.Consume();
                            Console.WriteLine($"{cr.Message.Key}:{cr.Message.Value}");
                        }
                    }
                    catch (OperationCanceledException)
                    {
                        // Ctrl-C was pressed.
                    }
                    finally
                    {
                        consumer.Close();
                    }
                }
            }
        }
        ```

    1. Сборка и запуск приложений:

        ```bash
        cd ~/cs-project/consumer && dotnet build && \
        dotnet run bin/Debug/netcoreapp5.0/App.dll
        ```

        ```bash
        cd ~/cs-project/producer && dotnet build && \
        dotnet run bin/Debug/netcoreapp5.0/App.dll
        ```

- Подключение с SSL

    1. Пример кода для отправки сообщений в топик:

        `cs-project/producer/Program.cs`

        ```csharp
        using Confluent.Kafka;
        using System;
        using System.Collections.Generic;

        namespace App
        {
            class Program
            {
                public static void Main(string[] args)
                {
                    int MSG_COUNT = 5;

                    string HOST = "<FQDN_хоста-брокера>:9091";
                    string TOPIC = "<имя_топика>";
                    string USER = "<имя_производителя>";
                    string PASS = "<пароль_производителя>";
                    string CA_FILE = "{{ crt-local-dir }}{{ crt-local-file }}";

                    var producerConfig = new ProducerConfig(
                        new Dictionary<string,string>{
                            {"bootstrap.servers", HOST},
                            {"security.protocol", "SASL_SSL"},
                            {"ssl.ca.location", CA_FILE},
                            {"sasl.mechanism", "SCRAM-SHA-512"},
                            {"sasl.username", USER},
                            {"sasl.password", PASS}
                        }
                    );

                    var producer = new ProducerBuilder<string, string>(producerConfig).Build();

                    for(int i=0; i<MSG_COUNT; i++)
                    {
                        producer.Produce(TOPIC, new Message<string, string> { Key = "key", Value = "test message" },
                        (deliveryReport) =>
                            {
                                if (deliveryReport.Error.Code != ErrorCode.NoError)
                                {
                                    Console.WriteLine($"Failed to deliver message: {deliveryReport.Error.Reason}");
                                }
                                else
                                {
                                    Console.WriteLine($"Produced message to: {deliveryReport.TopicPartitionOffset}");
                                }
                        });
                     }
                     producer.Flush(TimeSpan.FromSeconds(10));
                }
            }
        }
        ```

    1. Пример кода для получения сообщений из топика:

        `cs-project/consumer/Program.cs`

        ```csharp
        using Confluent.Kafka;
        using System;
        using System.Collections.Generic;

        namespace CCloud
        {
            class Program
            {
                public static void Main(string[] args)
                {
                    string HOST = "<FQDN_хоста-брокера>:9091";
                    string TOPIC = "<имя_топика>";
                    string USER = "<имя_потребителя>";
                    string PASS = "<пароль_потребителя>";
                    string CA_FILE = "{{ crt-local-dir }}{{ crt-local-file }}";

                    var consumerConfig = new ConsumerConfig(
                        new Dictionary<string,string>{
                            {"bootstrap.servers", HOST},
                            {"security.protocol", "SASL_SSL"},
                            {"ssl.ca.location", CA_FILE},
                            {"sasl.mechanism", "SCRAM-SHA-512"},
                            {"sasl.username", USER},
                            {"sasl.password", PASS},
                            {"group.id", "demo"}
                        }
                    );

                    var consumer = new ConsumerBuilder<string, string>(consumerConfig).Build();
                    consumer.Subscribe(TOPIC);
                    try
                    {
                        while (true)
                        {
                            var cr = consumer.Consume();
                            Console.WriteLine($"{cr.Message.Key}:{cr.Message.Value}");
                        }
                    }
                    catch (OperationCanceledException)
                    {
                        // Ctrl-C was pressed.
                    }
                    finally
                    {
                        consumer.Close();
                    }
                }
            }
        }
        ```

    1. Сборка и запуск приложений:

        ```bash
        cd ~/cs-project/consumer && dotnet build && \
        dotnet run bin/Debug/netcoreapp5.0/App.dll
        ```

        ```bash
        cd ~/cs-project/producer && dotnet build && \
        dotnet run bin/Debug/netcoreapp5.0/App.dll
        ```

{% endlist %}

{% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

{% include [code-howto](../../_includes/mdb/mkf/connstr-code-howto.md) %}

### Go {#go}

Перед подключением:

1. Установите зависимости:

    ```bash
    sudo apt update && sudo apt install -y golang git && \
    go get github.com/Shopify/sarama && \
    go get github.com/xdg/scram
    ```

1. Создайте директорию для проекта:

    ```bash
    cd ~/ && mkdir go-project && cd go-project && mkdir -p consumer producer
    ```

1. Создайте файл `scram.go`, содержащий код для использования [SCRAM](https://github.com/xdg-go/scram), общий для приложения-производителя и приложения-потребителя:

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

1. Скопируйте `scram.go` в директории приложения-производителя и приложения-потребителя:

    ```bash
    cp scram.go producer/scram.go && cp scram.go consumer/scram.go
    ```

{% list tabs %}

- Подключение без SSL

    1. Пример кода для отправки сообщения в топик:

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
              brokers := "<FQDN_хоста-брокера>:9092"
              splitBrokers := strings.Split(brokers, ",")
              conf := sarama.NewConfig()
              conf.Producer.RequiredAcks = sarama.WaitForAll
              conf.Producer.Return.Successes = true
              conf.Version = sarama.V0_10_0_0
              conf.ClientID = "sasl_scram_client"
              conf.Net.SASL.Enable = true
              conf.Net.SASL.Handshake = true
              conf.Net.SASL.User = "<имя_производителя>"
              conf.Net.SASL.Password = "<пароль_производителя>"
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
          // Publish sync
          msg := &sarama.ProducerMessage {
              Topic: "<имя_топика>",
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

    1. Пример кода для получения сообщений из топика:

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
              brokers := "<FQDN_хоста-брокера>:9092"
              splitBrokers := strings.Split(brokers, ",")
              conf := sarama.NewConfig()
              conf.Producer.RequiredAcks = sarama.WaitForAll
              conf.Version = sarama.V0_10_0_0
              conf.Consumer.Return.Errors = true
              conf.ClientID = "sasl_scram_client"
              conf.Metadata.Full = true
              conf.Net.SASL.Enable = true
              conf.Net.SASL.User =  "<имя_потребителя>"
              conf.Net.SASL.Password = "<пароль_потребителя>"
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

              topic := "<имя_топика>"

              consumer, err := master.ConsumePartition(topic, 0, sarama.OffsetOldest)
              if err != nil {
                      panic(err)
              }

              signals := make(chan os.Signal, 1)
              signal.Notify(signals, os.Interrupt)

              // Count the number of processed messages
              msgCount := 0

              // Get signal to finish
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

    1. Сборка приложений:

        ```bash
        cd ~/go-project/producer && go build && \
        cd ~/go-project/consumer && go build
        ```

    1. Запуск приложений:

        ```bash
        ~/go-project/consumer/consumer
        ```

        ```bash
        ~/go-project/producer/producer
        ```

- Подключение с SSL

    1. Пример кода для отправки сообщения в топик:

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
              brokers := "<FQDN_хоста-брокера>:9091"
              splitBrokers := strings.Split(brokers, ",")
              conf := sarama.NewConfig()
              conf.Producer.RequiredAcks = sarama.WaitForAll
              conf.Producer.Return.Successes = true
              conf.Version = sarama.V0_10_0_0
              conf.ClientID = "sasl_scram_client"
              conf.Net.SASL.Enable = true
              conf.Net.SASL.Handshake = true
              conf.Net.SASL.User = "<имя_производителя>"
              conf.Net.SASL.Password = "<пароль_производителя>"
              conf.Net.SASL.SCRAMClientGeneratorFunc = func() sarama.SCRAMClient { return &XDGSCRAMClient{HashGeneratorFcn: SHA512} }
              conf.Net.SASL.Mechanism = sarama.SASLMechanism(sarama.SASLTypeSCRAMSHA512)

              certs := x509.NewCertPool()
              pemPath := "{{ crt-local-dir }}{{ crt-local-file }}"
              pemData, err := ioutil.ReadFile(pemPath)
              if err != nil {
                      fmt.Println("Couldn't load cert: ", err.Error())
                  // Handle the error
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
              Topic: "<имя_топика>",
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

    1. Пример кода для получения сообщений из топика:

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
              brokers := "<FQDN_хоста-брокера>:9091"
              splitBrokers := strings.Split(brokers, ",")
              conf := sarama.NewConfig()
              conf.Producer.RequiredAcks = sarama.WaitForAll
              conf.Version = sarama.V0_10_0_0
              conf.Consumer.Return.Errors = true
              conf.ClientID = "sasl_scram_client"
              conf.Metadata.Full = true
              conf.Net.SASL.Enable = true
              conf.Net.SASL.User =  "<имя_потребителя>"
              conf.Net.SASL.Password = "<пароль_потребителя>"
              conf.Net.SASL.Handshake = true
              conf.Net.SASL.SCRAMClientGeneratorFunc = func() sarama.SCRAMClient { return &XDGSCRAMClient{HashGeneratorFcn: SHA512} }
              conf.Net.SASL.Mechanism = sarama.SASLMechanism(sarama.SASLTypeSCRAMSHA512)

              certs := x509.NewCertPool()
              pemPath := "{{ crt-local-dir }}{{ crt-local-file }}"
              pemData, err := ioutil.ReadFile(pemPath)
              if err != nil {
                  fmt.Println("Couldn't load cert: ", err.Error())
                      // Handle the error
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

              topic := "<имя_топика>"

              consumer, err := master.ConsumePartition(topic, 0, sarama.OffsetOldest)
              if err != nil {
                      panic(err)
              }

              signals := make(chan os.Signal, 1)
              signal.Notify(signals, os.Interrupt)

              // Count the number of processed messages
              msgCount := 0

              // Get signal to finish
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

    1. Сборка приложений:

        ```bash
        cd ~/go-project/producer && go build && \
        cd ~/go-project/consumer && go build
        ```

    1. Запуск приложений:

        ```bash
        ~/go-project/consumer/consumer
        ```

        ```bash
        ~/go-project/producer/producer
        ```

{% endlist %}

{% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

{% include [code-howto](../../_includes/mdb/mkf/connstr-code-howto.md) %}

### Java {#java}

Перед подключением:

1. Установите зависимости:

   ```bash
   sudo apt update && sudo apt install --yes default-jdk maven
   ```

1. Создайте директорию для проекта Maven:

   ```bash
   cd ~/ && \
   mkdir --parents project/consumer/src/java/com/example project/producer/src/java/com/example && \
   cd ~/project
   ```

1. Создайте конфигурационный файл для Maven:    

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

   Актуальные версии зависимостей уточняйте на страницах соответствующих проектов в репозитории Maven:
   - [kafka-clients](https://mvnrepository.com/artifact/org.apache.kafka/kafka-clients);
   - [jackson-databind](https://mvnrepository.com/artifact/com.fasterxml.jackson.core/jackson-databind);
   - [slf4j-simple](https://mvnrepository.com/artifact/org.slf4j/slf4j-simple).

 1. Скопируйте `pom.xml` в директории приложения-производителя и приложения-потребителя:

    ```bash
    cp pom.xml producer/pom.xml && cp pom.xml consumer/pom.xml
    ```

{% list tabs %}

- Подключение без SSL

  1. Пример кода для отправки сообщений в топик:

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

          String HOST = "<FQDN_брокера>:9092";
          String TOPIC = "<имя_топика>";
          String USER = "<имя_производителя>";
          String PASS = "<пароль_производителя>";

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

  1. Пример кода для получения сообщений из топика:

      `consumer/src/java/com/example/App.java`

      ```java
      package com.example;

      import java.util.*;
      import org.apache.kafka.common.*;
      import org.apache.kafka.common.serialization.StringDeserializer;
      import org.apache.kafka.clients.consumer.*;

      public class App {

        public static void main(String[] args) {

          String HOST = "<FQDN_брокера>:9092";
          String TOPIC = "<имя_топика>";
          String USER = "<имя_потребителя>";
          String PASS = "<пароль_потребителя>";

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

  1. Сборка приложений:

      ```bash
      cd ~/project/producer && mvn clean package && \
      cd ~/project/consumer && mvn clean package
      ```

  1. Запуск приложений:

      ```bash
      java -jar ~/project/producer/target/app-0.1.0-jar-with-dependencies.jar
      ```

      ```bash
      java -jar ~/project/consumer/target/app-0.1.0-jar-with-dependencies.jar
      ```

- Подключение с SSL

  1. Перейдите в каталог, где будет располагаться хранилище сертификатов Java:

     ```bash
     cd /etc/security
     ```

  1. {% include [keytool-importcert](./keytool-importcert.md) %}

  1. Пример кода для отправки сообщений в топик:

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

          String HOST = "<FQDN_брокера>:9091";
          String TOPIC = "<имя_топика>";
          String USER = "<имя_производителя>";
          String PASS = "<пароль_производителя>";
          String TS_FILE = "/etc/security/ssl";
          String TS_PASS = "<пароль_от_хранилища_сертификатов>";

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

  1. Пример кода для получения сообщений из топика:

      `consumer/src/java/com/example/App.java`

      ```java
      package com.example;

      import java.util.*;
      import org.apache.kafka.common.*;
      import org.apache.kafka.common.serialization.StringDeserializer;
      import org.apache.kafka.clients.consumer.*;

      public class App {

        public static void main(String[] args) {

          String HOST = "<FQDN_брокера>:9091";
          String TOPIC = "<имя_топика>";
          String USER = "<имя_потребителя>";
          String PASS = "<пароль_потребителя>";
          String TS_FILE = "/etc/security/ssl";
          String TS_PASS = "<пароль_от_хранилища_сертификатов>";

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

  1. Сборка приложений:

      ```bash
      cd ~/project/producer && mvn clean package && \
      cd ~/project/consumer && mvn clean package
      ```

  1. Запуск приложений:

      ```bash
      java -jar ~/project/producer/target/app-0.1.0-jar-with-dependencies.jar
      ```

      ```bash
      java -jar ~/project/consumer/target/app-0.1.0-jar-with-dependencies.jar
      ```

{% endlist %}

{% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

{% include [code-howto](../../_includes/mdb/mkf/connstr-code-howto.md) %}

### Node.js {#nodejs}

Перед подключением установите зависимости:

```bash
sudo apt update && sudo apt install -y nodejs npm && \
npm install node-rdkafka
```

{% list tabs %}

- Подключение без SSL

  1. Пример кода для отправки сообщений в топик:

      `producer.js`

      ```js
      "use strict"
      const Kafka = require('node-rdkafka');

      const MSG_COUNT = 5;

      const HOST = "<FQDN_брокера>:9092";
      const TOPIC = "<имя_топика>";
      const USER = "<имя_производителя>";
      const PASS = "<пароль_производителя>";

      const producer = new Kafka.Producer({
        'bootstrap.servers': HOST,
        'sasl.username': USER,
        'sasl.password': PASS,
        'security.protocol': "SASL_PLAINTEXT",
        'sasl.mechanism': "SCRAM-SHA-512"
      });

      producer.connect();

      producer.on('ready', function() {
        try {
          for (let i = 0; i < MSG_COUNT; ++i) {
            producer.produce(TOPIC, -1, Buffer.from("test message"), "key");
            console.log("Produced: test message");
          }

          producer.flush(10000, () => {
              producer.disconnect();
            });
        } catch (err) {
          console.error('Error');
          console.error(err);
        }
      });
      ```

  1. Пример кода для получения сообщений из топика:

      `consumer.js`

      ```js
      "use strict"
      const Kafka = require('node-rdkafka');

      const MSG_COUNT = 5;

      const HOST = "<FQDN_брокера>:9092";
      const TOPIC = "<имя_топика>";
      const USER = "<имя_потребителя>";
      const PASS = "<пароль_потребителя>";

      const consumer = new Kafka.Consumer({
        'bootstrap.servers': HOST,
        'sasl.username': USER,
        'sasl.password': PASS,
        'security.protocol': "SASL_PLAINTEXT",
        'sasl.mechanism': "SCRAM-SHA-512",
        'group.id': "demo"
      });

      consumer.connect();

      consumer
        .on('ready', function() {
          consumer.subscribe([TOPIC]);
          consumer.consume();
        })
        .on('data', function(data) {
          console.log(data.key + ":" + data.value.toString());
        });

      process.on('SIGINT', () => {
        console.log('\nDisconnecting consumer ...');
        consumer.disconnect();
      });
      ```

  1. Запуск приложений:

      ```bash
      node consumer.js
      ```

      ```bash
      node producer.js
      ```

- Подключение с SSL

  1. Пример кода для отправки сообщений в топик:

      `producer.js`

      ```js
      "use strict"
      const Kafka = require('node-rdkafka');

      const MSG_COUNT = 5;

      const HOST = "<FQDN_брокера>:9091";
      const TOPIC = "<имя_топика>";
      const USER = "<имя_производителя>";
      const PASS = "<пароль_производителя>";
      const CA_FILE = "{{ crt-local-dir }}{{ crt-local-file }}";

      const producer = new Kafka.Producer({
        'bootstrap.servers': HOST,
        'sasl.username': USER,
        'sasl.password': PASS,
        'security.protocol': "SASL_SSL",
        'ssl.ca.location': CA_FILE,
        'sasl.mechanism': "SCRAM-SHA-512"
      });

      producer.connect();

      producer.on('ready', function() {
        try {
          for (let i = 0; i < MSG_COUNT; ++i) {
            producer.produce(TOPIC, -1, Buffer.from("test message"), "key");
            console.log("Produced: test message");
          }

          producer.flush(10000, () => {
              producer.disconnect();
            });
        } catch (err) {
          console.error('Error');
          console.error(err);
        }
      });
      ```

  1. Пример кода для получения сообщений из топика:

      `consumer.js`

      ```js
      "use strict"
      const Kafka = require('node-rdkafka');

      const MSG_COUNT = 5;

      const HOST = "<FQDN_брокера>:9091";
      const TOPIC = "<имя_топика>";
      const USER = "<имя_потребителя>";
      const PASS = "<пароль_потребителя>";
      const CA_FILE = "{{ crt-local-dir }}{{ crt-local-file }}";

      const consumer = new Kafka.Consumer({
        'bootstrap.servers': HOST,
        'sasl.username': USER,
        'sasl.password': PASS,
        'security.protocol': "SASL_SSL",
        'ssl.ca.location': CA_FILE,
        'sasl.mechanism': "SCRAM-SHA-512",
        'group.id': "demo"
      });

      consumer.connect();

      consumer
        .on('ready', function() {
          consumer.subscribe([TOPIC]);
          consumer.consume();
        })
        .on('data', function(data) {
          console.log(data.key + ":" + data.value.toString());
        });

      process.on('SIGINT', () => {
        console.log('\nDisconnecting consumer ...');
        consumer.disconnect();
      });
      ```

  1. Запуск приложений:

      ```bash
      node consumer.js
      ```

      ```bash
      node producer.js
      ```

{% endlist %}

{% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

{% include [code-howto](../../_includes/mdb/mkf/connstr-code-howto.md) %}

### PowerShell {#powershell}

Перед подключением:

1. Установите последнюю доступную версию [Microsoft OpenJDK](https://docs.microsoft.com/en-us/java/openjdk/download).

1. Загрузите [архив с бинарными файлами](https://kafka.apache.org/downloads) для версии {{ KF }}, которая используется в кластере. Версия Scala неважна.

1. Распакуйте архив.

   {% note tip %}

   Распаковывайте файлы {{ KF }} в корневой каталог диска, например, `C:\kafka_2.12-2.6.0\`. 
   
   Если путь к исполняемым и пакетным файлам {{ KF }} будет слишком длинным, то при попытке запустить их возникнет ошибка `The input line is too long`.

   {% endnote %}

{% list tabs %}

- Подключение без SSL

  1. Запустите команду получения сообщений из топика:

      ```powershell
      <путь_к_директории_с_файлами_Apache_Kafka>\bin\windows\kafka-console-consumer.bat `
          --bootstrap-server <FQDN_брокера>:9092 `
          --topic <имя_топика> `
          --property print.key=true `
          --property key.separator=":" `
          --consumer-property security.protocol=SASL_PLAINTEXT `
          --consumer-property sasl.mechanism=SCRAM-SHA-512 `
          --consumer-property sasl.jaas.config="org.apache.kafka.common.security.scram.ScramLoginModule required username='<логин_потребителя>' password='<пароль_потребителя>';" 
      ```

      Команда будет непрерывно считывать новые сообщения из топика.

  1. В отдельном терминале запустите команду отправки сообщения в топик:
      
      ```powershell
      echo "key:test message" | <путь_к_директории_с_файлами_Apache_Kafka>\bin\windows\kafka-console-producer.bat `
          --bootstrap-server <FQDN_брокера>:9092 `
          --topic <имя_топика> `
          --property parse.key=true `
          --property key.separator=":" `
          --producer-property acks=all `
          --producer-property security.protocol=SASL_PLAINTEXT `
          --producer-property sasl.mechanism=SCRAM-SHA-512 `
          --producer-property sasl.jaas.config="org.apache.kafka.common.security.scram.ScramLoginModule required username='<логин_производителя>' password='<пароль_производителя>';"
      ```

- Подключение с SSL

  1. Добавьте SSL-сертификат в хранилище доверенных сертификатов Java (Java Key Store), чтобы драйвер {{ KF }} мог использовать этот сертификат при защищенном подключении к хостам кластера. Задайте пароль в параметре `--storepass` для дополнительной защиты хранилища:

     ```powershell
     keytool.exe -importcert -alias {{ crt-alias }} `
       --file $HOME\.kafka\{{ crt-local-file }} `
       --keystore $HOME\.kafka\ssl `
       --storepass <пароль_хранилища_сертификатов> `
       --noprompt
     ```
  
  1. Запустите команду получения сообщений из топика:

      ```powershell
      <путь_к_директории_с_файлами_Apache_Kafka>\bin\windows\kafka-console-consumer.bat `
          --bootstrap-server <FQDN_брокера>:9091 `
          --topic <имя_топика> `
          --property print.key=true `
          --property key.separator=":" `
          --consumer-property security.protocol=SASL_SSL `
          --consumer-property sasl.mechanism=SCRAM-SHA-512 `
          --consumer-property ssl.truststore.location=$HOME\.kafka\ssl `
          --consumer-property ssl.truststore.password=<пароль_хранилища_сертификатов> `
          --consumer-property sasl.jaas.config="org.apache.kafka.common.security.scram.ScramLoginModule required username='<логин_потребителя>' password='<пароль_потребителя>';"
      ```

     Команда будет непрерывно считывать новые сообщения из топика.

  1. В отдельном терминале запустите команду отправки сообщения в топик:
     
      ```powershell
      echo "key:test message" | <путь_к_директории_с_файлами_Apache_Kafka>\bin\windows\kafka-console-producer.bat `
          --bootstrap-server <FQDN_брокера>:9091 `
          --topic <имя_топика> `
          --property parse.key=true `
          --property key.separator=":" `
          --producer-property acks=all `
          --producer-property security.protocol=SASL_SSL `
          --producer-property sasl.mechanism=SCRAM-SHA-512 `
          --producer-property ssl.truststore.location=$HOME\.kafka\ssl `
          --producer-property ssl.truststore.password=<пароль_хранилища_сертификатов> `
          --producer-property sasl.jaas.config="org.apache.kafka.common.security.scram.ScramLoginModule required username='<логин_производителя>' password='<пароль_производителя>';"
      ```

{% endlist %}

{% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

{% include [shell-howto](../../_includes/mdb/mkf/connstr-shell-howto.md) %}

### Python (kafka-python) {#kafka-python}

Перед подключением установите зависимости:

```bash
sudo apt update && sudo apt install -y python3 python3-pip libsnappy-dev && \
pip3 install kafka-python lz4 python-snappy crc32c
```

{% list tabs %}

- Подключение без SSL

  1. Пример кода для отправки сообщения в топик:

     `producer.py`

     ```python
     from kafka import KafkaProducer

     producer = KafkaProducer(
         bootstrap_servers='<FQDN_хоста-брокера>:9092',
         security_protocol="SASL_PLAINTEXT",
         sasl_mechanism="SCRAM-SHA-512",
         sasl_plain_username='<имя_производителя>',
         sasl_plain_password='<пароль_производителя>')

     producer.send('<имя_топика>', b'test message', b'key')
     producer.flush()
     producer.close()
     ```

  1. Пример кода для получения сообщений из топика:

     `consumer.py`

     ```python
     from kafka import KafkaConsumer

     consumer = KafkaConsumer(
         '<имя_топика>',
         bootstrap_servers='<FQDN_брокера>:9092',
         security_protocol="SASL_PLAINTEXT",
         sasl_mechanism="SCRAM-SHA-512",
         sasl_plain_username='<имя_потребителя>',
         sasl_plain_password='<пароль_потребителя>')

     print("ready")

     for msg in consumer:
         print(msg.key.decode("utf-8") + ":" + msg.value.decode("utf-8"))
     ```

  1. Запуск приложений:

      ```bash
      python3 producer.py
      ```

      ```bash
      python3 consumer.py
      ```

- Подключение с SSL

  1. Пример кода для отправки сообщения в топик:

      `producer.py`

      ```python
      from kafka import KafkaProducer

      producer = KafkaProducer(
          bootstrap_servers='<FQDN_хоста-брокера>:9091',
          security_protocol="SASL_SSL",
          sasl_mechanism="SCRAM-SHA-512",
          sasl_plain_username='<имя_производителя>',
          sasl_plain_password='<пароль_производителя>',
          ssl_cafile="{{ crt-local-dir }}{{ crt-local-file }}")

      producer.send('<имя_топика>', b'test message', b'key')
      producer.flush()
      producer.close()
      ```

  1. Пример кода для получения сообщений из топика:

      `consumer.py`

      ```python
      from kafka import KafkaConsumer

      consumer = KafkaConsumer(
          '<имя_топика>',
          bootstrap_servers='<FQDN_брокера>:9091',
          security_protocol="SASL_SSL",
          sasl_mechanism="SCRAM-SHA-512",
          sasl_plain_username='<имя_потребителя>',
          sasl_plain_password='<пароль_потребителя>',
          ssl_cafile="{{ crt-local-dir }}{{ crt-local-file }}")

      print("ready")

      for msg in consumer:
          print(msg.key.decode("utf-8") + ":" + msg.value.decode("utf-8"))
      ```

  1. Запуск приложений:

      ```bash
      python3 consumer.py
      ```

      ```bash
      python3 producer.py
      ```

{% endlist %}

{% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

{% include [code-howto](../../_includes/mdb/mkf/connstr-code-howto.md) %}

### Python (confluent-kafka) {#confluent-kafka-python}

Перед подключением установите зависимости:

```bash
pip install confluent_kafka
```

{% list tabs %}

- Подключение без SSL

  1. Пример кода для отправки сообщения в топик:

      `producer.py`

      ```python
      from confluent_kafka import Producer

      def error_callback(err):
          print('Something went wrong: {}'.format(err))

      params = {
          'bootstrap.servers': '<FQDN_хоста-брокера>:9092',
          'security.protocol': 'SASL_PLAINTEXT',
          'sasl.mechanism': 'SCRAM-SHA-512',
          'sasl.username': '<имя_производителя>',
          'sasl.password': '<пароль_производителя>',
          'error_cb': error_callback,
      }

      p = Producer(params)
      p.produce('<имя_топика>', 'some payload1')
      p.flush(10)
      ```

  1. Пример кода для получения сообщений из топика:

      `consumer.py`

      ```python
      from confluent_kafka import Consumer

      def error_callback(err):
          print('Something went wrong: {}'.format(err))

      params = {
          'bootstrap.servers': '<FQDN_хоста-брокера>:9092',
          'security.protocol': 'SASL_PLAINTEXT',
          'sasl.mechanism': 'SCRAM-SHA-512',
          'sasl.username': '<имя_потребителя>',
          'sasl.password': '<пароль_потребителя>',
          'group.id': 'test-consumer1',
          'auto.offset.reset': 'earliest',
          'enable.auto.commit': False,
          'error_cb': error_callback,
          'debug': 'all',
      }
      c = Consumer(params)
      c.subscribe(['<имя_топика>'])
      while True:
          msg = c.poll(timeout=3.0)
          if msg:
              val = msg.value().decode()
              print(val)
      ```

  1. Запуск приложений:

      ```bash
      python3 producer.py
      ```

      ```bash
      python3 consumer.py
      ```

- Подключение с SSL

  1. Пример кода для отправки сообщения в топик:

      `producer.py`

      ```python
      from confluent_kafka import Producer

      def error_callback(err):
          print('Something went wrong: {}'.format(err))

      params = {
          'bootstrap.servers': '<FQDN_хоста-брокера>:9091',
          'security.protocol': 'SASL_SSL',
          'ssl.ca.location': '{{ crt-local-dir }}{{ crt-local-file }}',
          'sasl.mechanism': 'SCRAM-SHA-512',
          'sasl.username': '<имя_производителя>',
          'sasl.password': '<пароль_производителя>',
          'error_cb': error_callback,
      }

      p = Producer(params)
      p.produce('<имя_топика>', 'some payload1')
      p.flush(10)
      ```

  1. Пример кода для получения сообщений из топика:

      `consumer.py`

      ```python
      from confluent_kafka import Consumer

      def error_callback(err):
          print('Something went wrong: {}'.format(err))

      params = {
          'bootstrap.servers': '<FQDN_хоста-брокера>:9091',
          'security.protocol': 'SASL_SSL',
          'ssl.ca.location': '{{ crt-local-dir }}{{ crt-local-file }}',
          'sasl.mechanism': 'SCRAM-SHA-512',
          'sasl.username': '<имя_потребителя>',
          'sasl.password': '<пароль_потребителя>',
          'group.id': 'test-consumer1',
          'auto.offset.reset': 'earliest',
          'enable.auto.commit': False,
          'error_cb': error_callback,
          'debug': 'all',
      }
      c = Consumer(params)
      c.subscribe(['<имя_топика>'])
      while True:
          msg = c.poll(timeout=3.0)
          if msg:
              val = msg.value().decode()
              print(val)
      ```

  1. Запуск приложений:

      ```bash
      python3 consumer.py
      ```

      ```bash
      python3 producer.py
      ```

{% endlist %}

{% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

{% include [code-howto](../../_includes/mdb/mkf/connstr-code-howto.md) %}
