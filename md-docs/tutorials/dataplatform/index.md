# Построение Data Platform на базе Yandex Cloud

## Apache Kafka® {#kafka}

* [Самостоятельное развертывание веб-интерфейса Apache Kafka®](deploy-kafka-ui.md)
* [Обновление кластера Managed Service for Apache Kafka® с ZooKeeper на кластер с поддержкой KRaft](zk-kraft-kafka-migration.md)
* [Миграция базы данных из стороннего кластера Apache Kafka® в Yandex Managed Service for Apache Kafka®](kafka-connector.md)
* [Перенос данных между кластерами Managed Service for Apache Kafka® с помощью Data Transfer](data-transfer-mkf.md)
* [Поставка данных из Yandex Managed Service for MySQL® в Yandex Managed Service for Apache Kafka® с помощью Yandex Data Transfer](data-transfer-mmy.md)
* [Поставка данных из Yandex Managed Service for MySQL® в Yandex Managed Service for Apache Kafka® с помощью Debezium](debezium-mmy.md)
* [Поставка данных из Yandex Managed Service for PostgreSQL в Yandex Managed Service for Apache Kafka® с помощью Yandex Data Transfer](data-transfer-mpg.md)
* [Поставка данных из Yandex Managed Service for PostgreSQL в Yandex Managed Service for Apache Kafka® с помощью Debezium](debezium-mpg.md)
* [Поставка данных из Yandex Managed Service for YDB в Yandex Managed Service for Apache Kafka® с помощью Yandex Data Transfer](ydb-mkf-replication.md)
* [Поставка данных из Yandex Managed Service for Apache Kafka® в Yandex Managed Service for ClickHouse® с помощью Yandex Data Transfer](data-transfer-mkf-mch.md)
* [Поставка данных из Yandex Managed Service for Apache Kafka® в Yandex MPP Analytics for PostgreSQL с помощью Yandex Data Transfer](managed-kafka-to-greenplum.md)
* [Поставка данных из Yandex Managed Service for Apache Kafka® в Yandex StoreDoc с помощью Yandex Data Transfer](data-transfer-mkf-mmg.md)
* [Поставка данных из Yandex Managed Service for Apache Kafka® в Yandex Managed Service for MySQL® с помощью Yandex Data Transfer](data-transfer-mkf-mmy.md)
* [Поставка данных из Yandex Managed Service for Apache Kafka® в Yandex Managed Service for OpenSearch с помощью Yandex Data Transfer](data-transfer-mkf-mos.md)
* [Поставка данных из Yandex Managed Service for Apache Kafka® в Yandex Managed Service for PostgreSQL с помощью Yandex Data Transfer](mkf-to-mpg.md)
* [Поставка данных из Yandex Managed Service for Apache Kafka® в Yandex Managed Service for YDB с помощью Yandex Data Transfer](mkf-ydb-stream.md)
* [Поставка данных из Yandex Managed Service for Apache Kafka® в Yandex Data Streams с помощью Yandex Data Transfer](mkf-yds-stream.md)
* [Поставка данных из очереди Data Streams в Managed Service for Apache Kafka® с помощью Yandex Data Transfer](yds-to-kafka.md)
* [Настройка Kafka Connect для работы с кластером Yandex Managed Service for Apache Kafka®](kafka-connect.md)
* [Синхронизация данных из топиков Apache Kafka® в бакет Object Storage без использования интернета](kafka-topic-s3-sync-private.md)
* Использование реестра схем форматов данных с Yandex Managed Service for Apache Kafka®:
  * [Управление схемами данных в Managed Service for Apache Kafka®](schema-registry-overview.md)
  * [Использование Managed Schema Registry с Yandex Managed Service for Apache Kafka®](managed-schema-registry.md)
  * [Использование Managed Schema Registry с Yandex Managed Service for Apache Kafka® с помощью REST API](managed-schema-registry-rest.md)
  * [Использование Confluent Schema Registry с Yandex Managed Service for Apache Kafka®](confluent-schema-registry.md)
* [Отслеживание потери сообщений в топике Apache Kafka®](retention-policy.md)

## Apache Airflow™ {#airflow}

* [Автоматизация задач Yandex Query с помощью Yandex Managed Service for Apache Airflow™](airflow-auto-tasks.md)
* [Отправка запросов к API Yandex Cloud через Yandex Cloud Python SDK](using-python-sdk-in-airflow.md)
* [Настройка SMTP-сервера для отправки уведомлений по электронной почте](airflow-test-smtp-notification.md)
* [Запуск PySpark-задания с помощью Yandex Managed Service for Apache Airflow™](airflow-spark-min.md)

## ClickHouse® {#clickhouse}

* [Добавление данных в ClickHouse®](insert-data-ch.md)
* [Миграция данных в Managed Service for ClickHouse® средствами ClickHouse®](clickhouse-migration.md)
* [Миграция данных в Yandex Managed Service for ClickHouse® при помощи Yandex Data Transfer](ch-to-mch-migration.md)
* [Миграция базы данных из MySQL® в ClickHouse® с помощью Yandex Data Transfer](mysql-to-clickhouse.md)
* [Асинхронная репликация данных из PostgreSQL в ClickHouse®](rdbms-to-clickhouse.md)
* [Обмен данными между Yandex Managed Service for ClickHouse® и Yandex Data Processing](dp-mch-data-exchange.md)
* [Настройка Yandex Managed Service for ClickHouse® для Graphite](clickhouse-for-graphite.md)
* [Получение данных из Yandex Managed Service for Apache Kafka® в Yandex Managed Service for ClickHouse®](fetch-data-from-mkf.md)
* [Поставка данных в ksqlDB](use-ksqldb-with-mkf.md)
* [Поставка данных из Yandex Managed Service for Apache Kafka® в Yandex Managed Service for ClickHouse® с помощью Yandex Data Transfer](data-transfer-mkf-mch.md)
* [Получение данных из RabbitMQ в Yandex Managed Service for ClickHouse®](fetch-data-from-rabbitmq.md)
* [Сохранение потока данных Yandex Data Streams в Yandex Managed Service for ClickHouse®](yds-to-clickhouse.md)
* [Использование гибридного хранилища в Yandex Managed Service for ClickHouse®](clickhouse-hybrid-storage.md)
* [Шардирование таблиц Yandex Managed Service for ClickHouse®](clickhouse-sharding.md)
* [Загрузка данных из Яндекс Директ в витрину Yandex Managed Service for ClickHouse® с использованием Yandex Cloud Functions, Yandex Object Storage и Yandex Data Transfer](data-transfer-direct-to-mch.md)
* [Загрузка данных из Yandex Object Storage в Yandex Managed Service for ClickHouse® с помощью Yandex Data Transfer](object-storage-to-clickhouse.md)
* [Копирование данных из Managed Service for OpenSearch в Managed Service for ClickHouse® с помощью Yandex Data Transfer](opensearch-to-clickhouse.md)
* [Загрузка данных из Yandex Managed Service for YDB в Yandex Managed Service for ClickHouse® с помощью Yandex Data Transfer](ydb-to-clickhouse.md)
* [Миграция базы данных из Google BigQuery в Yandex Managed Service for ClickHouse®](bigquery-to-clickhouse.md)
* [Интеграция Yandex Managed Service for ClickHouse® с внешней базой данных Microsoft SQL Server через ClickHouse® JDBC Bridge](jdbc-ch-to-sql-server-integration.md)
* [Интеграция Yandex Managed Service for ClickHouse® с Oracle через ClickHouse® JDBC Bridge](jdbc-ch-to-oracle-integration.md)

## Greenplum® {#greenplum}

* [Поставка данных из Yandex Managed Service for Apache Kafka® в Yandex MPP Analytics for PostgreSQL с помощью Yandex Data Transfer](managed-kafka-to-greenplum.md)
* [Миграция данных из Yandex Managed Service for MySQL® в Yandex MPP Analytics for PostgreSQL с помощью Yandex Data Transfer](mmy-to-mgp.md)
* [Миграция базы данных из Greenplum® в ClickHouse®](greenplum-to-clickhouse.md)
* [Миграция базы данных из Greenplum® в PostgreSQL](greenplum-to-postgresql.md)
* [Выгрузка данных Greenplum® в холодное хранилище Yandex Object Storage](greenplum-yezzey.md)
* [Загрузка данных из Yandex Object Storage в Yandex MPP Analytics for PostgreSQL с помощью Yandex Data Transfer](object-storage-to-greenplum.md)
* [Копирование данных из Managed Service for OpenSearch в Yandex MPP Analytics for PostgreSQL с помощью Yandex Data Transfer](opensearch-to-greenplum.md)
* [Создание внешней таблицы на базе таблицы из бакета Yandex Object Storage с помощью конфигурационного файла](mgp-config-server-for-s3.md)
* [Получение данных из внешних источников с помощью именованных запросов](pxf-named-queries.md)

## MongoDB/Yandex StoreDoc {#mongodb}

* [Перенос коллекций из MongoDB в Yandex StoreDoc](mongodb-migration-with-data-transfer.md)
* [Миграция данных в Yandex StoreDoc](storedoc-data-migration.md)
* [Миграция кластера Yandex StoreDoc с версии 4.4 на 6.0 c помощью Yandex Data Transfer](storedoc-versions.md)
* [Шардирование коллекций Yandex StoreDoc](storedoc-sharding.md)
* [Анализ производительности и оптимизация MongoDB](storedoc-profiling.md)
* [Поставка данных из Yandex Managed Service for Apache Kafka® в Yandex StoreDoc с помощью Yandex Data Transfer](data-transfer-mkf-mmg.md)


## MySQL® {#mysql}

* [Миграция базы данных из стороннего кластера MySQL® в кластер Yandex Managed Service for MySQL®](mysql-data-migration/index.md)
* [Анализ производительности и оптимизация Managed Service for MySQL®](profiling-mmy.md)
* [Синхронизация данных из стороннего кластера MySQL® в Yandex Managed Service for MySQL® с помощью Yandex Data Transfer](sync-mysql.md)
* [Миграция базы данных из Yandex Managed Service for MySQL® в сторонний кластер MySQL®](mmy-to-mysql-migration.md)
* [Поставка данных из Yandex Managed Service for Apache Kafka® в Yandex Managed Service for MySQL® с помощью Yandex Data Transfer](data-transfer-mkf-mmy.md)
* [Миграция базы данных из MySQL® в ClickHouse® с помощью Yandex Data Transfer](mysql-to-clickhouse.md)
* [Миграция базы данных из Yandex Managed Service for MySQL® в Yandex Object Storage](mmy-objs-migration.md)
* [Миграция данных из Yandex Object Storage в Yandex Managed Service for MySQL® с помощью Yandex Data Transfer](objs-mmy-migration.md)
* [Захват изменений MySQL® и поставка в YDS](mmy-to-yds.md)
* [Миграция данных из Managed Service for MySQL® в Managed Service for PostgreSQL с помощью Data Transfer](mmy-to-mpg.md)
* [Миграция данных из Yandex Managed Service for MySQL® в Yandex MPP Analytics for PostgreSQL с помощью Yandex Data Transfer](mmy-to-mgp.md)
* [Импорт данных из Yandex Managed Service for MySQL® в Yandex Data Processing с помощью Sqoop](sqoop-mmy.md)
* [Поставка данных из Yandex Managed Service for MySQL® в Yandex Managed Service for Apache Kafka® с помощью Yandex Data Transfer](data-transfer-mmy.md)
* [Поставка данных из Yandex Managed Service for MySQL® в Yandex Managed Service for Apache Kafka® с помощью Debezium](debezium-mmy.md)
* [Миграция базы данных из Yandex Managed Service for MySQL® в Yandex Managed Service for YDB с помощью Yandex Data Transfer](mmy-ydb-migration.md)


## OpenSearch {#opensearch}

* [Настройка политики индексов в Yandex Managed Service for OpenSearch](opensearch-index-policy.md)
* [Настройка политики холодного хранилища в Yandex Managed Service for OpenSearch](opensearch-cold-storage-policy.md)
* [Поставка данных из Yandex Managed Service for Apache Kafka® в Yandex Managed Service for OpenSearch с помощью Yandex Data Transfer](data-transfer-mkf-mos.md)
* [Миграция данных в Yandex Managed Service for OpenSearch из стороннего кластера OpenSearch с помощью Yandex Data Transfer](mos-migration-from-standalone.md)
* [Загрузка данных из Yandex Managed Service for OpenSearch в Yandex Object Storage с помощью Yandex Data Transfer](opensearch-to-object-storage.md)
* [Миграция данных из Yandex Managed Service for OpenSearch в Yandex Managed Service for YDB с помощью Yandex Data Transfer](opensearch-to-ydb.md)
* [Копирование данных из Managed Service for OpenSearch в Yandex MPP Analytics for PostgreSQL с помощью Yandex Data Transfer](opensearch-to-greenplum.md)
* [Копирование данных из Managed Service for OpenSearch в Managed Service for ClickHouse® с помощью Yandex Data Transfer](opensearch-to-clickhouse.md)
* [Миграция данных из Yandex Managed Service for PostgreSQL в Yandex Managed Service for OpenSearch с помощью Yandex Data Transfer](postgresql-to-opensearch.md)
* [Аутентификация в OpenSearch Dashboards кластера Yandex Managed Service for OpenSearch с помощью Keycloak](opensearch-saml-keycloak.md)
* [Использование плагина yandex-lemmer в Yandex Managed Service for OpenSearch](opensearch-yandex-lemmer.md)
* [Отправка оповещений по электронной почте в Yandex Managed Service for OpenSearch](opensearch-email-notifications.md)

## PostgreSQL {#postgresql}

* [Создание кластера PostgreSQL для «1С:Предприятия»](1c-postgresql.md)
* [Поиск проблем с производительностью кластера Managed Service for PostgreSQL](mpg-performance-problems.md)
* [Анализ производительности и оптимизация Managed Service for PostgreSQL](mpg-profiling.md)
* [Логическая репликация PostgreSQL](mpg-replication-overview.md)
* [Миграция базы данных из стороннего кластера PostgreSQL в Managed Service for PostgreSQL](postgresql-data-migration.md)
* [Миграция базы данных из Managed Service for PostgreSQL](outbound-replication.md)
* [Миграция кластера Yandex Managed Service for PostgreSQL на другую версию c помощью Yandex Data Transfer](postgresql-versions.md)
* [Асинхронная репликация данных из PostgreSQL в ClickHouse®](rdbms-to-clickhouse.md)
* [Поставка данных из Yandex Managed Service for Apache Kafka® в Yandex Managed Service for PostgreSQL с помощью Yandex Data Transfer](mkf-to-mpg.md)
* [Поставка данных из Yandex Managed Service for PostgreSQL в Yandex Managed Service for Apache Kafka® с помощью Yandex Data Transfer](data-transfer-mpg.md)
* [Поставка данных из Yandex Managed Service for PostgreSQL в Yandex Managed Service for Apache Kafka® с помощью Debezium](debezium-mpg.md)
* [Импорт данных из Yandex Managed Service for PostgreSQL в Yandex Data Processing с помощью Sqoop](sqoop-mpg.md)
* [Поставка данных из Yandex Managed Service for PostgreSQL в Yandex Managed Service for YDB с помощью Yandex Data Transfer](mpg-ydb-replication.md)
* [Миграция базы данных из Managed Service for PostgreSQL в Object Storage](mpg-to-objstorage.md)
* [Перенос данных из Yandex Object Storage в Yandex Managed Service for PostgreSQL с использованием Yandex Data Transfer](object-storage-to-postgresql.md)
* [Миграция данных из Managed Service for PostgreSQL в Managed Service for MySQL® с помощью Data Transfer](mpg-to-mmy.md)
* [Захват изменений PostgreSQL и поставка в YDS](mpg-to-yds.md)
* [Миграция данных из AWS RDS for PostgreSQL в Yandex Managed Service for PostgreSQL с помощью Yandex Data Transfer](rds-to-mpg.md)
* [Миграция данных из Yandex Managed Service for PostgreSQL в Yandex Managed Service for OpenSearch с помощью Yandex Data Transfer](postgresql-to-opensearch.md)
* [Решение проблем с сортировкой строк в PostgreSQL после обновления glibc](postgresql-glibc-collation-issues.md)
* [Использование секрета Yandex Lockbox в PySpark-задании для подключения к Yandex Managed Service for PostgreSQL](job-pyspark-secret-access.md)
* [Настройка прав доступа к секрету, созданному Yandex Connection Manager, для пользователя Yandex Managed Service for PostgreSQL](conn-man-secret-access.md)

## Valkey™ {#valkey}

* [Миграция базы данных из стороннего кластера Valkey™ в Yandex Managed Service for Valkey™](valkey-data-migration.md)
* [Использование кластера Yandex Managed Service for Valkey™ в качестве хранилища сессий PHP](valkey-as-php-sessions-storage.md)

## YDB {#ydb}

* [Поставка данных из Yandex Managed Service for YDB в Yandex Managed Service for Apache Kafka® с помощью Yandex Data Transfer](ydb-mkf-replication.md)
* [Поставка данных из Yandex Managed Service for Apache Kafka® в Yandex Managed Service for YDB с помощью Yandex Data Transfer](mkf-ydb-stream.md)
* [Миграция базы данных из Yandex Managed Service for MySQL® в Yandex Managed Service for YDB с помощью Yandex Data Transfer](mmy-ydb-migration.md)
* [Поставка данных из Yandex Managed Service for PostgreSQL в Yandex Managed Service for YDB с помощью Yandex Data Transfer](mpg-ydb-replication.md)
* [Загрузка данных из Yandex Object Storage в Yandex Managed Service for YDB с помощью Yandex Data Transfer](object-storage-to-ydb.md)
* [Загрузка данных из Yandex Managed Service for YDB в Yandex Object Storage с помощью Yandex Data Transfer](ydb-to-object-storage.md)
* [Загрузка данных из Yandex Managed Service for YDB в Yandex Managed Service for ClickHouse® с помощью Yandex Data Transfer](ydb-to-clickhouse.md)
* [Миграция данных из Yandex Managed Service for OpenSearch в Yandex Managed Service for YDB с помощью Yandex Data Transfer](opensearch-to-ydb.md)
* [Поставка данных из очереди Data Streams в Managed Service for YDB с помощью Yandex Data Transfer](yds-to-ydb.md)
* [Захват изменений Yandex Managed Service for YDB и поставка в Yandex Data Streams](ydb-to-yds.md)

## Yandex Cloud DNS {#dns}

* [Настройка Yandex Cloud DNS для доступа к кластеру Yandex Managed Service for ClickHouse® из других облачных сетей](clickhouse-dns-peering.md)

## Yandex Data Processing {#dataproc}

* [Миграция кластера Yandex Data Processing с файловой системой HDFS в другую зону доступности](hdfs-cluster-migration.md)
* [Обмен данными между Yandex Managed Service for ClickHouse® и Yandex Data Processing](dp-mch-data-exchange.md)
* [Импорт данных из Yandex Managed Service for MySQL® в Yandex Data Processing с помощью Sqoop](sqoop-mmy.md)
* [Импорт данных из Yandex Managed Service for PostgreSQL в Yandex Data Processing с помощью Sqoop](sqoop-mpg.md)
* [Монтирование бакетов Yandex Object Storage к файловой системе хостов Yandex Data Processing](data-processing-init-actions-geesefs.md)
* [Работа с топиками Apache Kafka® с помощью PySpark-заданий в Yandex Data Processing](data-processing-and-kafka.md)
* [Автоматизация работы с Yandex Data Processing с помощью Yandex Managed Service for Apache Airflow™](data-processing-and-airflow.md)
* [Совместная работа с таблицами Yandex Data Processing с использованием Apache Hive™ Metastore](data-processing-to-data-processing.md)
* [Перенос метаданных между кластерами Yandex Data Processing с помощью Apache Hive™ Metastore](metastore-import.md)
* [Импорт данных из Yandex Object Storage, обработка и экспорт в Yandex Managed Service for ClickHouse®](s3-data-processing-ch.md)
* [Использование сервиса Yandex Managed Service for Apache Spark™ в Yandex DataSphere](spark-and-datasphere.md)

### Базовые примеры работы с заданиями {#jobs-basic-tutorials}

* [Работа с заданиями Hive](hive-job-basics.md)
* [Работа с заданиями MapReduce](mapreduce-job-basics.md)
* [Работа с заданиями PySpark](pyspark-job-basics.md)
* [Работа с заданиями Spark](spark-job-basics.md)

### Продвинутые примеры работы с заданиями {#jobs-advanced-tutorials}

* [Запуск заданий Apache Hive](how-to-use-hive.md)
* [Запуск и управление приложениями для Spark и PySpark](run-spark-job.md)
* [Запуск заданий с удаленных хостов, не входящих в кластер Yandex Data Processing](remote-run-job.md)

## Yandex Query {#query}

* [Обработка аудитных логов Yandex Audit Trails](audit-log-processing.md)
* [Обработка логов Yandex Cloud Logging](cloud-logging-processing.md)
* [Обработка потока изменений Debezium](debezium-yq.md)
* [Анализ данных с помощью Jupyter](jupyter-yq.md)
* [Обработка файлов детализации в сервисе Yandex Cloud Billing](billing-detail-files-processing.md)

## Yandex Data Streams {#yds}

* [Ввод данных в системы хранения](data-ingestion.md)
* [Умная обработка логов](log-ingestion.md)
* [Передача данных в микросервисных архитектурах](message-broker.md)
* [Миграция данных в Yandex Object Storage с помощью Yandex Data Transfer](yds-obj-migration.md)

## Yandex Data Transfer {#data-transfer}

* [Миграция данных из стороннего кластера Greenplum® или PostgreSQL в Yandex MPP Analytics for PostgreSQL с помощью Yandex Data Transfer](managed-greenplum.md)
* [Миграция кластера MongoDB](storedoc.md)
* [Миграция кластера MySQL®](managed-mysql.md)
* [Миграция на сторонний кластер MySQL®](managed-mysql-to-mysql.md)
* [Миграция кластера PostgreSQL](managed-postgresql.md)
* [Миграция кластера Yandex Managed Service for PostgreSQL на другую версию c помощью Yandex Data Transfer](postgresql-versions.md)
* [Создание реестра схем для поставки данных в формате Debezium CDC из Apache Kafka®](schema-registry-cdc-debezium-kafka.md)

## Yandex Managed Service for Apache Spark™ {#spark}

* [Автоматизация работы с помощью Yandex Managed Service for Apache Airflow™](airflow-and-spark.md)
* [Работа с таблицей в Object Storage из PySpark-задания с использованием Apache Hive™ Metastore и Apache Iceberg™](spark-simple-rw-job.md)
* [Интеграция Yandex Managed Service for Apache Spark™ и Apache Hive™ Metastore](metastore-and-spark.md)
* [Запуск PySpark-задания с помощью Yandex Managed Service for Apache Airflow™](airflow-spark-min.md)
* [Использование Yandex Object Storage в сервисе Yandex Managed Service for Apache Spark™](spark-objstorage-integration.md)
* [Использование сервиса Yandex Managed Service for Apache Spark™ в Yandex DataSphere](spark-and-datasphere.md)
* [Использование секрета Yandex Lockbox в PySpark-задании для подключения к Yandex Managed Service for PostgreSQL](job-pyspark-secret-access.md)


## Yandex Managed Service for YTsaurus {#ytsaurus}

* [Запуск PySpark-задания в Yandex Managed Service for YTsaurus](yt-run-spark-job.md)


_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._