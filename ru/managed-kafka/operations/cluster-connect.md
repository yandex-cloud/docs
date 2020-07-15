# Подключение к топикам в кластере {{ KF }}

К хостам кластера {{ mkf-short-name }} можно подключиться только с виртуальных машин Яндекс.Облака, расположенных в той же [виртуальной сети](../../vpc/concepts/network.md), что и кластер.

Чтобы подключиться к кластеру используйте:
* [Kafka Producer API](https://kafka.apache.org/documentation/#producerapi) — для подключения производителей данных.
* [Kafka Consumer API](https://kafka.apache.org/documentation/#consumerapi) — для подключения потребителей данных.
* Утилиту [kafkacat](https://github.com/edenhill/kafkacat) — для ручной записи сообщений в топики и чтения из них.

## Строка подключения {#connection-string}

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% list tabs %}

- Shell

  Для подлкючения к кластеру {{ KF }} из командной строки используйте kafkacat. kafkacat — это утилита с открытым исходным кодом, которая может работать как универсальный производитель или потребитель данных. Подробнее о приложении читайте в [документации](https://github.com/edenhill/kafkacat).
  
   1. Установите 
   1. foo
  
  
- Python

   1. Установите зависимости:
   
      ```bash
      pip install kafka-python
      ```
   
   1. Пример кода производителя данных:
   
      ```python
      from kafka import KafkaProducer
      
      producer = KafkaProducer(
          bootstrap_servers={{hostnames}},
          security_protocol="SASL_PLAINTEXT",
          sasl_mechanism="SCRAM-SHA-512",
          sasl_plain_password=<producer-name>,
          sasl_plain_username=<password>)
      ```
   
   1. Пример кода потребителя данных:
   
      ```python
      from kafka import KafkaConsumer
      
      consumer = KafkaConsumer(
          bootstrap_servers={{hostnames}},
          security_protocol="SASL_PLAINTEXT",
          sasl_mechanism="SCRAM-SHA-512",
          sasl_plain_password=<consumer-name>,
          sasl_plain_username=<password>)
      ```

- Java
 
   foo

- Go

   bar

{% endlist %}


### Установка kafkacat