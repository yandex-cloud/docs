[Документация Yandex Cloud](../../index.md) > [Yandex MPP Analytics for PostgreSQL](../index.md) > Практические руководства > Все руководства

# Практические руководства Yandex MPP Analytics for PostgreSQL

* [Миграция базы данных в Yandex MPP Analytics for PostgreSQL](data-migration.md)
* [Создание внешней таблицы на базе таблицы из бакета Yandex Object Storage с помощью конфигурационного файла](config-server-for-s3.md)
* [Получение данных из внешних источников с помощью именованных запросов](pxf-named-queries.md)
* [Миграция базы данных из Greenplum® в PostgreSQL](greenplum-to-postgresql.md)
* [Миграция базы данных из Greenplum® в ClickHouse®](greenplum-to-clickhouse.md)
* [Миграция данных из Yandex Managed Service for MySQL® в Yandex MPP Analytics for PostgreSQL с помощью Yandex Data Transfer](mmy-to-mgp.md)
* [Выгрузка данных кластера в холодное хранилище Yandex Object Storage](yezzey.md)
* [Загрузка данных из Yandex Object Storage в Yandex MPP Analytics for PostgreSQL с помощью Yandex Data Transfer](object-storage-to-greenplum.md)
* [Копирование данных из Managed Service for OpenSearch в Yandex MPP Analytics for PostgreSQL с помощью Yandex Data Transfer](opensearch-to-greenplum.md)
* [Поставка данных из Yandex Managed Service for Apache Kafka® с помощью Yandex Data Transfer](managed-kafka-to-greenplum.md)

## Поставка данных c помощью Data Transfer {#data-transfer}

* [Из Apache Kafka® в Greenplum®](managed-kafka-to-greenplum.md)

Если вы хотите провести миграцию хостов кластера в другую зону доступности, [восстановите кластер из резервной копии](../operations/cluster-backups.md#restore). Во время восстановления укажите нужную зону.