# Yandex Data Transfer

Сервис Yandex Data Transfer предназначен для логического переноса данных между источниками и приемниками. В качестве источников и приемников данных могут выступать СУБД, объектные хранилища или брокеры сообщений.

Yandex Data Transfer позволяет: <ul> <li>Переносить ваши базы данных в облако — как в сервисы управляемых баз данных, так и в собственные инсталляции на базе ВМ Yandex Compute Cloud.</li> <li>Создавать удаленные реплики баз данных.</li> <li>Агрегировать данные из разных источников в едином хранилище данных (Data Warehouse) на базе ClickHouse®.</li> <li>Резервировать и сохранять данные из любых доступных источников в Yandex Object Storage.</li> <li>Сохранять в облачные хранилища произвольные данные, которые поступают от брокеров сообщений.</li>

Data Transfer поддерживает несколько сценариев переноса, все они позволяют сохранять рабочее состояние источника и минимизировать время простоя использующих его приложений.

Уровень обслуживания сервиса определен в документе <a href="https://yandex.ru/legal/cloud_sla_data_transfer/">Уровень обслуживания Сервиса Транспортировки Данных / Yandex Data Transfer</a>.

# Yandex Data Transfer

 - [Доступные трансферы](transfer-matrix.md)

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

 - [Подготовка к трансферу](operations/prepare.md)

### Настройка эндпоинтов

 - [Управление эндпоинтами](operations/endpoint/index.md)

 - [Миграция эндпоинтов в другую зону доступности](operations/endpoint/migration-to-an-availability-zone.md)

#### Apache Kafka®

 - [Источник](operations/endpoint/source/kafka.md)

 - [Приемник](operations/endpoint/target/kafka.md)

#### AWS CloudTrail

 - [Источник](operations/endpoint/source/aws-cloudtrail.md)

#### BigQuery

 - [Источник](operations/endpoint/source/bigquery.md)

#### ClickHouse

 - [Источник](operations/endpoint/source/clickhouse.md)

 - [Приемник](operations/endpoint/target/clickhouse.md)

#### Elasticsearch

 - [Источник](operations/endpoint/source/elasticsearch.md)

 - [Приемник](operations/endpoint/target/elasticsearch.md)

#### Greenplum®

 - [Источник](operations/endpoint/source/greenplum.md)

 - [Приемник](operations/endpoint/target/greenplum.md)

#### Metrica

 - [Источник](operations/endpoint/source/metrika.md)

#### Microsoft SQL Server

 - [Источник](operations/endpoint/source/mssql.md)

#### MongoDB/Yandex StoreDoc

 - [Источник](operations/endpoint/source/mongodb.md)

 - [Приемник](operations/endpoint/target/mongodb.md)

#### MySQL

 - [Источник](operations/endpoint/source/mysql.md)

 - [Приемник](operations/endpoint/target/mysql.md)

#### Object Storage

 - [Источник](operations/endpoint/source/object-storage.md)

 - [Приемник](operations/endpoint/target/object-storage.md)

#### OpenSearch

 - [Источник](operations/endpoint/source/opensearch.md)

 - [Приемник](operations/endpoint/target/opensearch.md)

#### Oracle

 - [Источник](operations/endpoint/source/oracle.md)

#### PostgreSQL

 - [Источник](operations/endpoint/source/postgresql.md)

 - [Приемник](operations/endpoint/target/postgresql.md)

#### S3

 - [Источник](operations/endpoint/source/s3.md)

#### Yandex Data Streams

 - [Источник](operations/endpoint/source/data-streams.md)

 - [Приемник](operations/endpoint/target/data-streams.md)

#### YDB

 - [Источник](operations/endpoint/source/ydb.md)

 - [Приемник](operations/endpoint/target/yandex-database.md)

#### YTsaurus

 - [Источник](operations/endpoint/source/yt.md)

 - [Приемник](operations/endpoint/target/yt.md)

 - [Управление трансфером](operations/transfer.md)

 - [Работа с базами данных во время трансфера](operations/db-actions.md)

 - [Мониторинг состояния трансфера](operations/monitoring.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

### Миграция

 - [Кластер PostgreSQL](tutorials/managed-postgresql.md)

 - [Миграция кластера Managed Service for PostgreSQL на другую версию](tutorials/postgresql-versions.md)

 - [Данные в MySQL®](tutorials/managed-mysql.md)

 - [Сторонний кластер MySQL®](tutorials/managed-mysql-to-mysql.md)

 - [Кластер MongoDB](tutorials/storedoc.md)

 - [Миграция кластера Yandex StoreDoc (Managed Service for MongoDB) с версии 4.4 на 6.0](tutorials/storedoc-versions.md)

 - [Кластер ClickHouse®](tutorials/managed-clickhouse.md)

 - [Кластер Greenplum®](tutorials/managed-greenplum.md)

 - [Миграция из AWS RDS for PostgreSQL](tutorials/rds-to-mpg.md)

 - [Кластер OpenSearch](tutorials/os-to-mos.md)

### Зеркалирование данных

 - [Apache Kafka®](tutorials/mkf-to-mkf.md)

### Синхронизация данных

 - [Синхронизация данных из стороннего кластера MySQL® в Yandex Managed Service for MySQL®](tutorials/sync-mysql.md)

### Миграция со сменой типа хранения данных

 - [MySQL® в YDB](tutorials/managed-mysql-to-ydb.md)

 - [PostgreSQL в YDB](tutorials/mpg-to-ydb.md)

 - [MySQL® в PostgreSQL](tutorials/mmy-to-mpg.md)

 - [PostgreSQL в MySQL®](tutorials/mpg-to-mmy.md)

 - [MySQL® в Greenplum®](tutorials/mmy-to-mgp.md)

 - [OpenSearch в YDB](tutorials/opensearch-to-ydb.md)

 - [OpenSearch в Greenplum®](tutorials/opensearch-to-greenplum.md)

 - [PostgreSQL в OpenSearch](tutorials/postgresql-to-opensearch.md)

 - [Elasticsearch в OpenSearch](tutorials/mes-to-mos.md)

### Захват изменений данных и поставка в очередь

 - [MySQL® в Apache Kafka®](tutorials/cdc-mmy.md)

 - [MySQL® в YDS](tutorials/mmy-to-yds.md)

 - [PostgreSQL в Apache Kafka®](tutorials/cdc-mpg.md)

 - [PostgreSQL в YDS](tutorials/mpg-to-yds.md)

 - [YDB в Apache Kafka®](tutorials/cdc-ydb.md)

 - [YDB и поставка в YDS](tutorials/ydb-to-yds.md)

### Поставка данных из очередей

 - [Apache Kafka® в ClickHouse®](tutorials/mkf-to-mch.md)

 - [Apache Kafka® в PostgreSQL](tutorials/mkf-to-mpg.md)

 - [Apache Kafka® в Greenplum®](tutorials/managed-kafka-to-greenplum.md)

 - [Apache Kafka® в Yandex StoreDoc](tutorials/mkf-to-mmg.md)

 - [Apache Kafka® в MySQL®](tutorials/mkf-to-mmy.md)

 - [Apache Kafka® в OpenSearch](tutorials/mkf-to-mos.md)

 - [Apache Kafka® в YDB](tutorials/mkf-to-ydb.md)

 - [Apache Kafka® в YDS](tutorials/mkf-to-yds.md)

 - [YDS в Apache Kafka®](tutorials/yds-to-kafka.md)

 - [YDS в ClickHouse®](tutorials/yds-to-clickhouse.md)

 - [YDS в Object Storage](tutorials/yds-to-objstorage.md)

 - [YDS в OpenSearch](tutorials/trails-to-os.md)

 - [YDS в YDB](tutorials/yds-to-ydb.md)

 - [Ввод данных в системы хранения](tutorials/data-ingestion.md)

### Загрузка данных в витрины

 - [Greenplum® в ClickHouse®](tutorials/greenplum-to-clickhouse.md)

 - [MySQL® в ClickHouse®](tutorials/mysql-to-clickhouse.md)

 - [Яндекс Метрика в ClickHouse®](tutorials/metrika-to-clickhouse.md)

 - [PostgreSQL в ClickHouse®](tutorials/rdbms-to-clickhouse.md)

 - [Greenplum® в PostgreSQL](tutorials/greenplum-to-postgresql.md)

 - [Object Storage в MySQL®](tutorials/objs-mmy-migration.md)

 - [Object Storage в PostgreSQL](tutorials/object-storage-to-postgresql.md)

 - [Object Storage в Greenplum®](tutorials/object-storage-to-greenplum.md)

 - [Яндекс Директ в ClickHouse®](tutorials/direct-to-mch.md)

 - [Object Storage в ClickHouse®](tutorials/object-storage-to-clickhouse.md)

 - [Object Storage в YDB](tutorials/object-storage-to-ydb.md)

 - [YDB в ClickHouse®](tutorials/ydb-to-clickhouse.md)

 - [OpenSearch в ClickHouse®](tutorials/opensearch-to-clickhouse.md)

### Загрузка данных в Object Storage

 - [MySQL® в Object Storage](tutorials/mmy-objs-migration.md)

 - [PostgreSQL в Object Storage](tutorials/mpg-to-objstorage.md)

 - [OpenSearch в Object Storage](tutorials/opensearch-to-object-storage.md)

 - [Managed Service for YDB в Object Storage](tutorials/ydb-to-object-storage.md)

 - [Репликация логов в Object Storage с помощью Data Streams](tutorials/replicate-logs-to-storage-via-data-streams.md)

 - [Репликация логов в Object Storage с помощью Fluent Bit](tutorials/replicate-logs-to-storage.md)

## Концепции

 - [Взаимосвязь ресурсов сервиса](concepts/index.md)

 - [Типы и жизненные циклы трансферов](concepts/transfer-lifecycle.md)

 - [Объекты, переносимые трансфером](concepts/transferred-objects.md)

 - [Периодическое инкрементальное копирование](concepts/regular-incremental-copy.md)

 - [Параллельное копирование](concepts/sharded.md)

 - [Трансформация данных](concepts/data-transformation.md)

 - [Сериализация](concepts/serializer.md)

 - [Работа Yandex Data Transfer с источниками и приемниками](concepts/work-with-endpoints.md)

 - [Гарантии поставки](concepts/delivery-configuration.md)

 - [Операции над трансфером](concepts/operations.md)

 - [Сеть в Yandex Data Transfer](concepts/network.md)

 - [Скорость копирования данных в Yandex Data Transfer](concepts/copy-speed.md)

 - [Захват изменения данных](concepts/cdc.md)

 - [Какие задачи решает сервис](concepts/use-cases.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Решение проблем](troubleshooting/index.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### endpoint

 - [Overview](cli-ref/endpoint/index.md)

#### create

 - [Overview](cli-ref/endpoint/create/index.md)

 - [clickhouse-source](cli-ref/endpoint/create/clickhouse-source.md)

 - [clickhouse-target](cli-ref/endpoint/create/clickhouse-target.md)

 - [mongo-source](cli-ref/endpoint/create/mongo-source.md)

 - [mongo-target](cli-ref/endpoint/create/mongo-target.md)

 - [mysql-source](cli-ref/endpoint/create/mysql-source.md)

 - [mysql-target](cli-ref/endpoint/create/mysql-target.md)

 - [postgres-source](cli-ref/endpoint/create/postgres-source.md)

 - [postgres-target](cli-ref/endpoint/create/postgres-target.md)

 - [yds-source](cli-ref/endpoint/create/yds-source.md)

 - [yds-target](cli-ref/endpoint/create/yds-target.md)

 - [delete](cli-ref/endpoint/delete.md)

 - [get](cli-ref/endpoint/get.md)

 - [list](cli-ref/endpoint/list.md)

#### update

 - [Overview](cli-ref/endpoint/update/index.md)

 - [clickhouse-source](cli-ref/endpoint/update/clickhouse-source.md)

 - [clickhouse-target](cli-ref/endpoint/update/clickhouse-target.md)

 - [mongo-source](cli-ref/endpoint/update/mongo-source.md)

 - [mongo-target](cli-ref/endpoint/update/mongo-target.md)

 - [mysql-source](cli-ref/endpoint/update/mysql-source.md)

 - [mysql-target](cli-ref/endpoint/update/mysql-target.md)

 - [postgres-source](cli-ref/endpoint/update/postgres-source.md)

 - [postgres-target](cli-ref/endpoint/update/postgres-target.md)

 - [yds-source](cli-ref/endpoint/update/yds-source.md)

 - [yds-target](cli-ref/endpoint/update/yds-target.md)

### transfer

 - [Overview](cli-ref/transfer/index.md)

 - [activate](cli-ref/transfer/activate.md)

 - [create](cli-ref/transfer/create.md)

 - [deactivate](cli-ref/transfer/deactivate.md)

 - [delete](cli-ref/transfer/delete.md)

 - [get](cli-ref/transfer/get.md)

 - [list](cli-ref/transfer/list.md)

 - [update](cli-ref/transfer/update.md)

### v0

 - [Overview](cli-ref/v0/index.md)

#### endpoint

 - [Overview](cli-ref/v0/endpoint/index.md)

##### create

 - [Overview](cli-ref/v0/endpoint/create/index.md)

 - [clickhouse-source](cli-ref/v0/endpoint/create/clickhouse-source.md)

 - [clickhouse-target](cli-ref/v0/endpoint/create/clickhouse-target.md)

 - [mongo-source](cli-ref/v0/endpoint/create/mongo-source.md)

 - [mongo-target](cli-ref/v0/endpoint/create/mongo-target.md)

 - [mysql-source](cli-ref/v0/endpoint/create/mysql-source.md)

 - [mysql-target](cli-ref/v0/endpoint/create/mysql-target.md)

 - [postgres-source](cli-ref/v0/endpoint/create/postgres-source.md)

 - [postgres-target](cli-ref/v0/endpoint/create/postgres-target.md)

 - [yds-source](cli-ref/v0/endpoint/create/yds-source.md)

 - [yds-target](cli-ref/v0/endpoint/create/yds-target.md)

 - [delete](cli-ref/v0/endpoint/delete.md)

 - [get](cli-ref/v0/endpoint/get.md)

 - [list](cli-ref/v0/endpoint/list.md)

##### update

 - [Overview](cli-ref/v0/endpoint/update/index.md)

 - [clickhouse-source](cli-ref/v0/endpoint/update/clickhouse-source.md)

 - [clickhouse-target](cli-ref/v0/endpoint/update/clickhouse-target.md)

 - [mongo-source](cli-ref/v0/endpoint/update/mongo-source.md)

 - [mongo-target](cli-ref/v0/endpoint/update/mongo-target.md)

 - [mysql-source](cli-ref/v0/endpoint/update/mysql-source.md)

 - [mysql-target](cli-ref/v0/endpoint/update/mysql-target.md)

 - [postgres-source](cli-ref/v0/endpoint/update/postgres-source.md)

 - [postgres-target](cli-ref/v0/endpoint/update/postgres-target.md)

 - [yds-source](cli-ref/v0/endpoint/update/yds-source.md)

 - [yds-target](cli-ref/v0/endpoint/update/yds-target.md)

#### transfer

 - [Overview](cli-ref/v0/transfer/index.md)

 - [activate](cli-ref/v0/transfer/activate.md)

 - [create](cli-ref/v0/transfer/create.md)

 - [deactivate](cli-ref/v0/transfer/deactivate.md)

 - [delete](cli-ref/v0/transfer/delete.md)

 - [get](cli-ref/v0/transfer/get.md)

 - [list](cli-ref/v0/transfer/list.md)

 - [update](cli-ref/v0/transfer/update.md)

 - [Справочник Terraform](tf-ref.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### Endpoint

 - [Overview](api-ref/grpc/Endpoint/index.md)

 - [Get](api-ref/grpc/Endpoint/get.md)

 - [List](api-ref/grpc/Endpoint/list.md)

 - [Create](api-ref/grpc/Endpoint/create.md)

 - [Update](api-ref/grpc/Endpoint/update.md)

 - [Delete](api-ref/grpc/Endpoint/delete.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

#### Transfer

 - [Overview](api-ref/grpc/Transfer/index.md)

 - [Create](api-ref/grpc/Transfer/create.md)

 - [Update](api-ref/grpc/Transfer/update.md)

 - [Delete](api-ref/grpc/Transfer/delete.md)

 - [List](api-ref/grpc/Transfer/list.md)

 - [Get](api-ref/grpc/Transfer/get.md)

 - [Deactivate](api-ref/grpc/Transfer/deactivate.md)

 - [Activate](api-ref/grpc/Transfer/activate.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### Endpoint

 - [Overview](api-ref/Endpoint/index.md)

 - [Get](api-ref/Endpoint/get.md)

 - [List](api-ref/Endpoint/list.md)

 - [Create](api-ref/Endpoint/create.md)

 - [Update](api-ref/Endpoint/update.md)

 - [Delete](api-ref/Endpoint/delete.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

#### Transfer

 - [Overview](api-ref/Transfer/index.md)

 - [Create](api-ref/Transfer/create.md)

 - [Update](api-ref/Transfer/update.md)

 - [Delete](api-ref/Transfer/delete.md)

 - [List](api-ref/Transfer/list.md)

 - [Get](api-ref/Transfer/get.md)

 - [Deactivate](api-ref/Transfer/deactivate.md)

 - [Activate](api-ref/Transfer/activate.md)

 - [Метрики Monitoring](metrics.md)

 - [Аудитные логи Audit Trails](at-ref.md)

 - [Публичные материалы](public-talks.md)

## История изменений

 - [Все изменения](release-notes/index.md)

### 2025 год

 - [Декабрь 2025](release-notes/2512.md)

 - [Ноябрь 2025](release-notes/2511.md)

 - [Октябрь 2025](release-notes/2510.md)

 - [Сентябрь 2025](release-notes/2509.md)

 - [Август 2025](release-notes/2508.md)

 - [Июль 2025](release-notes/2507.md)

 - [Июнь 2025](release-notes/2506.md)

 - [Май 2025](release-notes/2505.md)

 - [Апрель 2025](release-notes/2504.md)

 - [Март 2025](release-notes/2503.md)

 - [Февраль 2025](release-notes/2502.md)

 - [Январь 2025](release-notes/2501.md)

### 2024 год

 - [Декабрь 2024](release-notes/2412.md)

 - [Ноябрь 2024](release-notes/2411.md)

 - [Октябрь 2024](release-notes/2410.md)

 - [Сентябрь 2024](release-notes/2409.md)

 - [Август 2024](release-notes/2408.md)

 - [Июль 2024](release-notes/2407.md)

 - [Июнь 2024](release-notes/2406.md)

 - [Май 2024](release-notes/2405.md)

 - [Апрель 2024](release-notes/2404.md)

 - [Март 2024](release-notes/2403.md)

 - [Февраль 2024](release-notes/2402.md)

 - [Январь 2024](release-notes/2401.md)

### 2023 год

 - [Декабрь 2023](release-notes/2312.md)

 - [Ноябрь 2023](release-notes/2311.md)

 - [Октябрь 2023](release-notes/2310.md)

 - [Сентябрь 2023](release-notes/2309.md)

 - [Август 2023](release-notes/2308.md)

 - [Обучающие курсы](training.md)