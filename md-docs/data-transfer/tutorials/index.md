# Практические руководства Data Transfer


C помощью Data Transfer вы можете реализовать различные сценарии миграции данных, захвата изменений, поставок данных из очередей, загрузки в витрины, зеркалирования и загрузки данных в масштабируемое хранилище.

## Миграция данных {#migration}

Миграция — задача, в рамках которой требуется перенести данные из одного хранилища в другое. В Data Transfer миграция часто означает перенос базы в облако из устаревших локальных баз в управляемые облачные.

![migration](../../_assets/data-transfer/tutorials/migration.svg)

* [Миграция кластера PostgreSQL](managed-postgresql.md)
* [Миграция кластера Managed Service for PostgreSQL на другую версию](postgresql-versions.md)
* [Миграция кластера MySQL®](managed-mysql-to-mysql.md)
* [Миграция кластера ClickHouse®](managed-clickhouse.md)
* [Миграция кластера Greenplum®](managed-greenplum.md)
* [Миграция кластера MongoDB](storedoc.md)
* [Миграция кластера Yandex StoreDoc (Managed Service for MongoDB) с версии 4.4 на 6.0](storedoc-versions.md)
* [Миграция из AWS RDS for PostgreSQL](rds-to-mpg.md)
* [Миграция кластера OpenSearch](os-to-mos.md)

Отдельной задачей миграции является зеркалирование данных между очередями.

* [Зеркалирование Apache Kafka®](mkf-to-mkf.md)

Синхронизация данных из стороннего кластера.

* [Синхронизация данных из MySQL®](sync-mysql.md)

Миграция со сменой типа хранения данных.

* [MySQL® в YDB](managed-mysql-to-ydb.md)
* [PostgreSQL в YDB](mpg-to-ydb.md)
* [MySQL® в PostgreSQL](mmy-to-mpg.md)
* [PostgreSQL в MySQL®](mpg-to-mmy.md)
* [MySQL® в Greenplum®](mmy-to-mgp.md)
* [OpenSearch в YDB](opensearch-to-ydb.md)
* [OpenSearch в Greenplum®](opensearch-to-greenplum.md)
* [PostgreSQL в OpenSearch](postgresql-to-opensearch.md)
* [Elasticsearch в OpenSearch](mes-to-mos.md)

## Захват изменений данных {#cdc}

[Change Data Capture](../concepts/cdc.md) (СDC) — это процесс отслеживания изменений в базе данных и поставка этих изменений потребителям, поддерживающий публичный формат сериализации при записи в очередь Debezium.
СDC используется для создания приложений, которые чувствительны к изменению данных в реальном времени, обмена данными между различными сервисами, в том числе, с разным уровнем доступности, сбора и поставки данных из продакшен-окружения во внутренние хранилища данных для обработки и анализа.

![cdc](../../_assets/data-transfer/tutorials/cdc.svg)

* Захват изменений MySQL® и поставка в:
  * [Apache Kafka®](cdc-mmy.md)
  * [YDS](mmy-to-yds.md)
* Захват изменений PostgreSQL и поставка в:
  * [Apache Kafka®](cdc-mpg.md)
  * [YDS](mpg-to-yds.md)
* Захват изменений YDB и поставка в:
  * [Apache Kafka®](cdc-ydb.md)
  * [YDS](ydb-to-yds.md)

## Поставка данных из очередей {#delivery-to-queue}

Поставка данных — процесс доставки произвольных данных в целевые хранилища. Процесс поставки включает извлечение данных из очереди и их десериализацию с последующей трансформацией данных в формат целевого хранилища.

![queue](../../_assets/data-transfer/tutorials/queue.svg)

* [Apache Kafka® в ClickHouse®](mkf-to-mch.md)
* [Apache Kafka® в PostgreSQL](mkf-to-mpg.md)
* [Apache Kafka® в Greenplum®](managed-kafka-to-greenplum.md)
* [Apache Kafka® в Yandex StoreDoc](mkf-to-mmg.md)
* [Apache Kafka® в MySQL®](mkf-to-mmy.md)
* [Apache Kafka® в OpenSearch](mkf-to-mos.md)
* [Apache Kafka® в YDB](mkf-to-ydb.md)

* [Apache Kafka® в YDS](mkf-to-yds.md)

* [YDS в ClickHouse®](yds-to-clickhouse.md)
* [YDS в Object Storage](yds-to-objstorage.md)
* [YDS в Managed Service for YDB](yds-to-ydb.md)
* [YDS в Apache Kafka®](yds-to-kafka.md)
* [Ввод данных в системы хранения](data-ingestion.md)

## Загрузка данных в витрины {#upload-to-data-mart}

Загрузка данных в витрины — процесс трансфера подготовленных данных в хранилища с целью последующей визуализации. Источники — хранилища, используемые для массивно-параллельной обработки данных. Приемники — хранилища, способные быстро отдать данные.

![data mart](../../_assets/data-transfer/tutorials/data-mart.svg)

* [Greenplum® в ClickHouse®](greenplum-to-clickhouse.md)
* [MySQL® в ClickHouse®](mysql-to-clickhouse.md)
* [Яндекс Метрика в ClickHouse®](metrika-to-clickhouse.md)
* [PostgreSQL в ClickHouse®](rdbms-to-clickhouse.md)
* [Greenplum® в PostgreSQL](greenplum-to-postgresql.md)
* [Яндекс Директ в ClickHouse®](direct-to-mch.md)
* [Object Storage в PostgreSQL](object-storage-to-postgresql.md)
* [Object Storage в Greenplum®](object-storage-to-greenplum.md)
* [Object Storage в MySQL®](objs-mmy-migration.md)
* [Object Storage в ClickHouse®](object-storage-to-clickhouse.md)
* [Object Storage в YDB](object-storage-to-ydb.md)
* [YDB в ClickHouse®](ydb-to-clickhouse.md)
* [OpenSearch в ClickHouse®](opensearch-to-clickhouse.md)

## Загрузка данных в Object Storage {#upload-to-storage}

Загрузка данных в масштабируемое хранилище Object Storage позволяет удешевить хранение и облегчает обмен данных с контрагентами.

![storage](../../_assets/data-transfer/tutorials/storage.svg)

* [MySQL® в Object Storage](mmy-objs-migration.md)
* [PostgreSQL в Object Storage](mpg-to-objstorage.md)
* [OpenSearch в Object Storage](opensearch-to-object-storage.md)
* [YDB в Object Storage](ydb-to-object-storage.md)
* [Репликация логов в Object Storage с помощью Data Streams](replicate-logs-to-storage-via-data-streams.md)
* [Репликация логов в Object Storage с помощью Fluent Bit](replicate-logs-to-storage.md)

_Greenplum® и Greenplum Database® являются зарегистрированными товарными знаками или товарными знаками Broadcom Inc в США и/или других странах._



_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._