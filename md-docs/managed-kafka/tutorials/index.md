[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Apache Kafka®](../index.md) > Практические руководства > Все руководства

# Практические руководства Managed Service for Apache Kafka®

Managed Service for Apache Kafka® можно использовать для передачи данных между базами данных. Источником или приемником может быть кластер Managed Service for Apache Kafka®, сторонний кластер Apache Kafka® или управляемая база данных Yandex Cloud.

## Перемещение данных из Apache Kafka® {#moving-data}

* [Настройка Kafka Connect для работы с кластером Managed Service for Apache Kafka®](kafka-connect.md)
* [Миграция базы данных из стороннего кластера Apache Kafka®](kafka-connectors.md)
* [Перенос данных между кластерами Managed Service for Apache Kafka® с помощью Yandex Data Transfer](mkf-to-mkf-transfer.md)

## Использование реестра схем формата данных с Managed Service for Apache Kafka® {#schema-registry}

* [Управление схемами данных в Managed Service for Apache Kafka®](schema-registry-overview.md)
* [Работа с управляемым реестром схем формата данных](managed-schema-registry.md)
* [Работа с управляемым реестром схем формата данных с помощью REST API](managed-schema-registry-rest.md)
* [Использование Confluent Schema Registry с Managed Service for Apache Kafka®](confluent-schema-registry.md)

## Поставка данных c помощью Data Transfer {#data-transfer}

* [Из PostgreSQL в Apache Kafka®](cdc/data-transfer-mpg.md)
* [Из Apache Kafka® в PostgreSQL](mkf-to-mpg.md)
* [Из YDB в Apache Kafka®](cdc/data-transfer-ydb.md)
* [Из Apache Kafka® в YDB](mkf-ydb-stream.md)
* [Из Apache Kafka® в ClickHouse®](mkf-to-mch-migration.md)
* [Из Apache Kafka® в Data Streams](mkf-yds-stream.md)
* [Из Data Streams в Apache Kafka®](yds-to-kafka.md)
* [Из Apache Kafka® в Greenplum®](managed-kafka-to-greenplum.md)
* [Из Apache Kafka® в MongoDB](mkf-to-mmg-migration.md)
* [Из MySQL® в Apache Kafka®](cdc/cdc-mmy.md)
* [Из Apache Kafka® в MySQL®](mkf-to-mmy-migration.md)
* [Из Apache Kafka® в OpenSearch](mkf-to-mos-migration.md)

## Поставка данных другими способами {#another-delivery}

* [Из PostgreSQL в Apache Kafka® с помощью Debezium](cdc/debezium-mpg.md)
* [Из MySQL® в Apache Kafka® с помощью Debezium](cdc/debezium-mmy.md)
* [Из Apache Kafka® в ClickHouse®](send-data-to-mch.md)
* [Из Apache Kafka® в ksqlDB](use-ksqldb-with-mkf.md)
* [Из Apache Kafka® в Object Storage без использования интернета](kafka-topic-s3-sync-private.md)

## Другое {#other}

* [Самостоятельное развертывание веб-интерфейса Apache Kafka®](deploy-kafka-ui.md)
* [Обновление кластера Managed Service for Apache Kafka® с ZooKeeper на кластер с поддержкой KRaft](zk-kraft-kafka-migration.md)
* [Работа с топиками Apache Kafka® с помощью PySpark-заданий в Yandex Data Processing](data-processing.md)
* [Отслеживание потери сообщений в топике Apache Kafka®](retention-policy.md)

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._