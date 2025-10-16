# Как отслеживать процесс чтения топиков в {{ mkf-name }}


## Описание сценария {#case-description}

Необходимо отследить процесс чтения топиков в {{ mkf-name }}

## Решение {#case-resolution}

Чтобы отслеживать процесс чтения топиков, используйте один из следующих способов:

- Просмотрите график [метрики](../../../managed-kafka/metrics.md) `kafka_group_topic_partition_lag` в {{ monitoring-full-name }}.
- Используйте инструмент командной строки `kafka-consumer-groups` — он поставляется вместе с дистрибутивом Kafka. 
  Пример команды:
  ```
  kafka-consumer-groups.sh --command-config connect --bootstrap-server <hostname>:9091 --group <group_name> --describe
  ```
- Подключите сторонний UI для кластера, который сможет отслеживать показатели `consumer group`: например, `Kafka UI` или `AKHQ`. Пример самостоятельного развертывания `Kafka UI` описан [в разделе руководств документации](../../../managed-kafka/tutorials/deploy-kafka-ui.md). 
