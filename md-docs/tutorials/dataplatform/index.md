[Документация Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > Построение Data Platform > Все руководства

# Построение Data Platform на базе Yandex Cloud


## Миграция данных и обновление версий СУБД {#migration}

Миграция — задача, в рамках которой требуется перенести данные из одного хранилища в другое: из локальных баз в управляемые облачные, между кластерами или со сменой типа СУБД. Практические руководства в этой группе описывают сценарии переноса для MySQL®, PostgreSQL, ClickHouse®, Greenplum®, MongoDB, YDB, OpenSearch и других систем, а также обновление версий баз данных с минимальным простоем.

{% cut "Полный перечень руководств" %}

* [Асинхронная репликация данных из PostgreSQL в ClickHouse®](rdbms-to-clickhouse.md)
* [Миграция базы данных из стороннего кластера MySQL® в кластер Yandex Managed Service for MySQL®](mysql-data-migration/index.md)
* [Миграция базы данных из стороннего кластера PostgreSQL в Managed Service for PostgreSQL](postgresql-data-migration.md)
* [Миграция базы данных из стороннего кластера Valkey™ в Yandex Managed Service for Valkey™](valkey-data-migration.md)
* [Миграция базы данных из Yandex Managed Service for MySQL® в сторонний кластер MySQL®](mmy-to-mysql-migration.md)
* [Миграция базы данных из MySQL® в ClickHouse® с помощью Yandex Data Transfer](mysql-to-clickhouse.md)
* [Миграция базы данных из Greenplum® в PostgreSQL](greenplum-to-postgresql.md)
* [Миграция данных в Managed Service for ClickHouse® средствами ClickHouse®](clickhouse-migration.md)
* [Миграция данных в Yandex Managed Service for ClickHouse® при помощи Yandex Data Transfer](ch-to-mch-migration.md)
* [Миграция данных в Yandex Managed Service for OpenSearch из стороннего кластера OpenSearch с помощью Yandex Data Transfer](mos-migration-from-standalone.md)
* [Миграция данных в Yandex Managed Service for OpenSearch из стороннего кластера OpenSearch с помощью Yandex Data Transfer](mos-migration-from-standalone.md)
* [Миграция данных в Yandex StoreDoc](storedoc-data-migration.md)
* [Миграция данных в Yandex Object Storage с помощью Yandex Data Transfer](yds-obj-migration.md)
* [Миграция данных из AWS RDS for PostgreSQL в Yandex Managed Service for PostgreSQL с помощью Yandex Data Transfer](rds-to-mpg.md)
* [Миграция данных из Yandex Managed Service for MySQL® в Yandex MPP Analytics for PostgreSQL с помощью Yandex Data Transfer](mmy-to-mgp.md)
* [Миграция данных из Managed Service for MySQL® в Managed Service for PostgreSQL с помощью Data Transfer](mmy-to-mpg.md)
* [Миграция данных из Managed Service for PostgreSQL в Managed Service for MySQL® с помощью Data Transfer](mpg-to-mmy.md)
* [Миграция данных из Yandex Managed Service for MySQL® в Yandex MPP Analytics for PostgreSQL с помощью Yandex Data Transfer](mmy-to-mgp.md)
* [Миграция данных из Managed Service for MySQL® в Managed Service for PostgreSQL с помощью Data Transfer](mmy-to-mpg.md)
* [Миграция данных из Managed Service for PostgreSQL в Managed Service for MySQL® с помощью Data Transfer](mpg-to-mmy.md)
* [Загрузка данных из Yandex Managed Service for YDB в Yandex Managed Service for PostgreSQL с помощью Yandex Data Transfer](ydb-to-postgresql.md)
* [Миграция данных из Yandex Object Storage в Yandex Managed Service for MySQL® с помощью Yandex Data Transfer](objs-mmy-migration.md)
* [Миграция базы данных из Google BigQuery в Yandex Managed Service for ClickHouse®](bigquery-to-clickhouse.md)
* [Миграция базы данных из Yandex Managed Service for MySQL® в Yandex Managed Service for YDB с помощью Yandex Data Transfer](mmy-ydb-migration.md)
* [Миграция базы данных из Yandex Managed Service for MySQL® в Yandex Object Storage](mmy-objs-migration.md)
* [Миграция базы данных из Greenplum® в ClickHouse®](greenplum-to-clickhouse.md)
* [Миграция кластера Yandex Managed Service for PostgreSQL на другую версию c помощью Yandex Data Transfer](postgresql-versions.md)
* [Миграция кластера Yandex StoreDoc с версии 4.4 на 6.0 c помощью Yandex Data Transfer](storedoc-versions.md)
* [Миграция кластера Yandex Data Processing с файловой системой HDFS в другую зону доступности](hdfs-cluster-migration.md)
* [Обновление кластера Managed Service for Apache Kafka® с ZooKeeper на кластер с поддержкой KRaft](zk-kraft-kafka-migration.md)

{% endcut %}


## Репликация и потоковый захват изменений данных {#replication}

Репликация и CDC (Change Data Capture) — процессы непрерывного отслеживания изменений в источнике и их доставки в приемник в режиме реального времени. Практические руководства этой группы описывают настройку репликации между кластерами, а также захват изменений с помощью Debezium и поставку потоков данных в системы-приемники.

{% cut "Полный перечень руководств" %}

* [Поставка данных из Yandex Managed Service for MySQL® в Yandex Managed Service for Apache Kafka® с помощью Debezium](debezium-mmy.md)
* [Поставка данных из Yandex Managed Service for PostgreSQL в Yandex Managed Service for Apache Kafka® с помощью Debezium](debezium-mpg.md)
* [Поставка данных из Yandex Managed Service for PostgreSQL в Yandex Managed Service for YDB с помощью Yandex Data Transfer](mpg-ydb-replication.md)
* [Поставка данных из Yandex Managed Service for YDB в Yandex Managed Service for Apache Kafka® с помощью Yandex Data Transfer](ydb-mkf-replication.md)
* [Обработка потока изменений Debezium](debezium-yq.md)
* [Синхронизация данных из стороннего кластера MySQL® в Yandex Managed Service for MySQL® с помощью Yandex Data Transfer](sync-mysql.md)
* [Миграция базы данных из Managed Service for PostgreSQL](outbound-replication.md)
* [Логическая репликация PostgreSQL](mpg-replication-overview.md)
* [Создание реестра схем для поставки данных в формате Debezium CDC из Apache Kafka®](schema-registry-cdc-debezium-kafka.md)

{% endcut %}


## Загрузка и поставка данных {#loading-delivery}

Практические руководства описывают архитектурные шаблоны для построения потоков данных: от источников (внешние базы, файлы, логи, брокеры) к хранилищам и обратно. Рассмотрены сценарии потоковой передачи через YDS, доставки событий из Apache Kafka® и RabbitMQ, пакетной загрузки и сквозного трансфера с помощью Data Transfer. 

{% cut "Полный перечень руководств" %}

* [Ввод данных в системы хранения](data-ingestion.md)
* [Умная обработка логов](log-ingestion.md)
* [Передача данных в микросервисных архитектурах](message-broker.md)
* [Добавление данных в ClickHouse®](insert-data-ch.md)
* [Получение данных из Yandex Managed Service for Apache Kafka® в Yandex Managed Service for ClickHouse®](fetch-data-from-mkf.md)
* [Получение данных из RabbitMQ в Yandex Managed Service for ClickHouse®](fetch-data-from-rabbitmq.md)
* [Поставка данных в ksqlDB](use-ksqldb-with-mkf.md)
* [Поставка данных из очереди Data Streams в Managed Service for Apache Kafka® с помощью Yandex Data Transfer](yds-to-kafka.md)
* [Поставка данных из Yandex Managed Service for Apache Kafka® в Yandex Data Streams с помощью Yandex Data Transfer](mkf-yds-stream.md)
* [Поставка данных из Yandex Managed Service for Apache Kafka® в Yandex Managed Service for YDB с помощью Yandex Data Transfer](mkf-ydb-stream.md)
* [Сохранение потока данных Yandex Data Streams в Yandex Managed Service for ClickHouse®](yds-to-clickhouse.md)
* [Поставка данных из очереди Data Streams в Managed Service for YDB с помощью Yandex Data Transfer](yds-to-ydb.md)
* [Захват изменений Yandex Managed Service for YDB и поставка в Yandex Data Streams](ydb-to-yds.md)
* [Поставка данных из Yandex Managed Service for Apache Kafka® в Yandex Managed Service for PostgreSQL с помощью Yandex Data Transfer](mkf-to-mpg.md)
* [Поставка данных из Yandex Managed Service for Apache Kafka® в Yandex MPP Analytics for PostgreSQL с помощью Yandex Data Transfer](managed-kafka-to-greenplum.md)
* [Миграция базы данных из стороннего кластера Apache Kafka® в Yandex Managed Service for Apache Kafka®](kafka-connector.md)
* [Настройка Kafka Connect для работы с кластером Yandex Managed Service for Apache Kafka®](kafka-connect.md)
* [Перенос данных между кластерами Managed Service for Apache Kafka® с помощью Data Transfer](data-transfer-mkf.md)
* [Поставка данных из Yandex Managed Service for MySQL® в Yandex Managed Service for Apache Kafka® с помощью Yandex Data Transfer](data-transfer-mmy.md)
* [Поставка данных из Yandex Managed Service for PostgreSQL в Yandex Managed Service for Apache Kafka® с помощью Yandex Data Transfer](data-transfer-mpg.md)
* [Поставка данных из Yandex Managed Service for Apache Kafka® в Yandex Managed Service for ClickHouse® с помощью Yandex Data Transfer](data-transfer-mkf-mch.md)
* [Поставка данных из Yandex Managed Service for Apache Kafka® в Yandex StoreDoc с помощью Yandex Data Transfer](data-transfer-mkf-mmg.md)
* [Поставка данных из Yandex Managed Service for Apache Kafka® в Yandex Managed Service for MySQL® с помощью Yandex Data Transfer](data-transfer-mkf-mmy.md)
* [Поставка данных из Yandex Managed Service for Apache Kafka® в Yandex Managed Service for OpenSearch с помощью Yandex Data Transfer](data-transfer-mkf-mos.md)
* [Загрузка данных из Яндекс Директ в витрину Yandex Managed Service for ClickHouse® с использованием Yandex Cloud Functions, Yandex Object Storage и Yandex Data Transfer](data-transfer-direct-to-mch.md)
* [Миграция данных из стороннего кластера Greenplum® или PostgreSQL в Yandex MPP Analytics for PostgreSQL с помощью Yandex Data Transfer](managed-greenplum.md)
* [Миграция кластера MySQL®](managed-mysql.md)
* [Миграция на сторонний кластер MySQL®](managed-mysql-to-mysql.md)
* [Миграция кластера PostgreSQL](managed-postgresql.md)
* [Миграция кластера MongoDB](storedoc.md)
* [Захват изменений MySQL® и поставка в YDS](mmy-to-yds.md)
* [Захват изменений PostgreSQL и поставка в YDS](mpg-to-yds.md)

{% endcut %}


## Интеграция и обмен между системами хранения и обработки данных {#integration}

Руководства этой группы описывают двусторонний обмен данными между разнородными хранилищами и вычислительными системами: ClickHouse®, Greenplum®, PostgreSQL, YDB, OpenSearch, Object Storage и внешними СУБД через JDBC. Сценарии включают поставку данных из аналитических кластеров в реляционные базы данных, обмен между Object Storage и сервисами управляемых баз данных, а также интеграцию OpenSearch с другими хранилищами.

{% cut "Полный перечень руководств" %}

* [Обмен данными между Yandex Managed Service for ClickHouse® и Yandex Data Processing](dp-mch-data-exchange.md)
* [Совместная работа с таблицами Yandex Data Processing с использованием Apache Hive™ Metastore](data-processing-to-data-processing.md)
* [Импорт данных из Yandex Object Storage, обработка и экспорт в Yandex Managed Service for ClickHouse®](s3-data-processing-ch.md)
* [Работа с топиками Apache Kafka® с помощью PySpark-заданий в Yandex Data Processing](data-processing-and-kafka.md)
* [Интеграция Yandex Managed Service for ClickHouse® с внешней базой данных Microsoft SQL Server через ClickHouse® JDBC Bridge](jdbc-ch-to-sql-server-integration.md)
* [Интеграция Yandex Managed Service for ClickHouse® с Oracle через ClickHouse® JDBC Bridge](jdbc-ch-to-oracle-integration.md)
* [Использование Yandex Object Storage в сервисе Yandex Managed Service for Apache Spark™](spark-objstorage-integration.md)
* [Выполнение аналитических запросов в Yandex Managed Service for PostgreSQL с обработкой в Yandex Managed Service for ClickHouse® при помощи pg_clickhouse и Yandex Data Transfer](mpg-pg-clickhouse-extension.md)
* [Загрузка данных из Yandex Object Storage в Yandex Managed Service for ClickHouse® с помощью Yandex Data Transfer](object-storage-to-clickhouse.md)
* [Загрузка данных из Yandex Object Storage в Yandex MPP Analytics for PostgreSQL с помощью Yandex Data Transfer](object-storage-to-greenplum.md)
* [Перенос данных из Yandex Object Storage в Yandex Managed Service for PostgreSQL с использованием Yandex Data Transfer](object-storage-to-postgresql.md)
* [Загрузка данных из Yandex Object Storage в Yandex Managed Service for YDB с помощью Yandex Data Transfer](object-storage-to-ydb.md)
* [Копирование данных из Managed Service for OpenSearch в Managed Service for ClickHouse® с помощью Yandex Data Transfer](opensearch-to-clickhouse.md)
* [Копирование данных из Managed Service for OpenSearch в Yandex MPP Analytics for PostgreSQL с помощью Yandex Data Transfer](opensearch-to-greenplum.md)
* [Миграция данных из Yandex Managed Service for OpenSearch в Yandex Managed Service for YDB с помощью Yandex Data Transfer](opensearch-to-ydb.md)
* [Загрузка данных из Yandex Managed Service for OpenSearch в Yandex Object Storage с помощью Yandex Data Transfer](opensearch-to-object-storage.md)
* [Миграция данных из Yandex Managed Service for PostgreSQL в Yandex Managed Service for OpenSearch с помощью Yandex Data Transfer](postgresql-to-opensearch.md)
* [Загрузка данных из Yandex Managed Service for YDB в Yandex Managed Service for ClickHouse® с помощью Yandex Data Transfer](ydb-to-clickhouse.md)
* [Миграция базы данных из Managed Service for PostgreSQL в Object Storage](mpg-to-objstorage.md)
* [Загрузка данных из Yandex Managed Service for YDB в Yandex Object Storage с помощью Yandex Data Transfer](ydb-to-object-storage.md)

{% endcut %}


## Аналитические вычисления {#analytical}

Руководства по запуску аналитических задач: Apache Spark™, PySpark, Apache Hive™ Metastore, MapReduce. Сюда входят сценарии удаленного запуска задач, чтения и записи данных, интеграции Apache Spark™ с Apache Hive™ Metastore и DataSphere, а также загрузки данных из реляционных источников через Sqoop.

{% cut "Полный перечень руководств" %}

* [Работа с заданиями Hive](hive-job-basics.md)
* [Работа с заданиями MapReduce](mapreduce-job-basics.md)
* [Работа с заданиями PySpark](pyspark-job-basics.md)
* [Работа с заданиями Spark](spark-job-basics.md)
* [Запуск заданий Apache Hive](how-to-use-hive.md)
* [Запуск и управление приложениями для Spark и PySpark](run-spark-job.md)
* [Запуск заданий с удаленных хостов, не входящих в кластер Yandex Data Processing](remote-run-job.md)
* [Работа с таблицей в Object Storage из PySpark-задания с использованием Apache Hive™ Metastore и Apache Iceberg™](spark-simple-rw-job.md)
* [Запуск PySpark-задания в Yandex Managed Service for YTsaurus](yt-run-spark-job.md)
* [Интеграция Yandex Managed Service for Apache Spark™ и Apache Hive™ Metastore](metastore-and-spark.md)
* [Перенос метаданных между кластерами Yandex Data Processing с помощью Apache Hive™ Metastore](metastore-import.md)
* [Использование сервиса Yandex Managed Service for Apache Spark™ в Yandex DataSphere](spark-and-datasphere.md)
* [Импорт данных из Yandex Managed Service for MySQL® в Yandex Data Processing с помощью Sqoop](sqoop-mmy.md)
* [Импорт данных из Yandex Managed Service for PostgreSQL в Yandex Data Processing с помощью Sqoop](sqoop-mpg.md)

{% endcut %}


## Оркестрация пайплайнов {#pipeline-orchestration}

Руководства по описанию автоматизации и планированию выполнения задач обработки данных с помощью Apache Airflow™. Сценарии включают автоматический запуск задач, использование Python SDK внутри DAG, совместный запуск Apache Airflow™ и Apache Spark™, а также настройку уведомлений по почте при сбоях в пайплайнах.

{% cut "Полный перечень руководств" %}

* [Автоматизация задач Yandex Query с помощью Yandex Managed Service for Apache Airflow™](airflow-auto-tasks.md)
* [Отправка запросов к API Yandex Cloud через Yandex Cloud Python SDK](using-python-sdk-in-airflow.md)
* [Автоматизация работы с помощью Yandex Managed Service for Apache Airflow™](airflow-and-spark.md)
* [Запуск PySpark-задания с помощью Yandex Managed Service for Apache Airflow™](airflow-spark-min.md)
* [Автоматизация работы с Yandex Data Processing с помощью Yandex Managed Service for Apache Airflow™](data-processing-and-airflow.md)
* [Настройка SMTP-сервера для отправки уведомлений по электронной почте](airflow-test-smtp-notification.md)

{% endcut %}


## Хранение, архивация, жизненный цикл данных {#storage-archiving}

Руководства по управлению жизненным циклом данных в хранилищах: гибридное хранение, шардирование, политики холодного хранения и ротации индексов в OpenSearch, настройка retention-политик, архивация данных.

{% cut "Полный перечень руководств" %}

* [Использование гибридного хранилища в Yandex Managed Service for ClickHouse®](clickhouse-hybrid-storage.md)
* [Шардирование таблиц Yandex Managed Service for ClickHouse®](clickhouse-sharding.md)
* [Шардирование коллекций Yandex StoreDoc](storedoc-sharding.md)
* [Настройка политики холодного хранилища в Yandex Managed Service for OpenSearch](opensearch-cold-storage-policy.md)
* [Настройка политики индексов в Yandex Managed Service for OpenSearch](opensearch-index-policy.md)
* [Выгрузка данных Greenplum® в гибридное хранилище Yandex Object Storage](greenplum-yezzey.md)
* [Отслеживание потери сообщений в топике Apache Kafka®](retention-policy.md)
* [Синхронизация данных из топиков Apache Kafka® в бакет Object Storage без использования интернета](kafka-topic-s3-sync-private.md)

{% endcut %}


## Производительность и диагностика {#productivity-diagnostics}

Диагностика узких мест, профилирование и устранение проблем производительности в СУБД и сервисах обработки. Сценарии помогут быстро локализовать и исправить проблемы с нагрузкой и скоростью выполнения запросов.

{% cut "Полный перечень руководств" %}

* [Поиск проблем с производительностью кластера Managed Service for PostgreSQL](mpg-performance-problems.md)
* [Анализ производительности и оптимизация Managed Service for PostgreSQL](mpg-profiling.md)
* [Анализ производительности и оптимизация Managed Service for MySQL®](profiling-mmy.md)
* [Анализ производительности и оптимизация MongoDB](storedoc-profiling.md)
* [Решение проблем с сортировкой строк в PostgreSQL после обновления glibc](postgresql-glibc-collation-issues.md)

{% endcut %}


## Мониторинг, логи, аудит, биллинг {#monitoring-logs}

Руководства по обработке и анализу различных видов телеметрии: аудитных логов, логов Cloud Logging, детализированных файлов биллинга, а также настройки уведомлений из OpenSearch и работы с Jupyter Notebook в связке с Yandex Query.

{% cut "Полный перечень руководств" %}

* [Обработка аудитных логов Yandex Audit Trails](audit-log-processing.md)
* [Обработка логов Yandex Cloud Logging](cloud-logging-processing.md)
* [Обработка файлов детализации в сервисе Yandex Cloud Billing](billing-detail-files-processing.md)
* [Отправка оповещений по электронной почте в Yandex Managed Service for OpenSearch](opensearch-email-notifications.md)
* [Анализ данных с помощью Jupyter](jupyter-yq.md)

{% endcut %}


## Безопасность и доступы {#security-and-access}

Сценарии настройки безопасного доступа к ресурсам платформы данных: аутентификация в OpenSearch через SAML и Keycloak, управление секретами при запуске PySpark‑задач и через Connection Manager, а также настройка DNS-peering для частной сети ClickHouse®.

{% cut "Полный перечень руководств" %}

* [Аутентификация в OpenSearch Dashboards кластера Yandex Managed Service for OpenSearch с помощью Keycloak](opensearch-saml-keycloak.md)
* [Использование секрета Yandex Lockbox в PySpark-задании для подключения к Yandex Managed Service for PostgreSQL](job-pyspark-secret-access.md)
* [Настройка прав доступа к секрету, созданному Yandex Connection Manager, для пользователя Yandex Managed Service for PostgreSQL](conn-man-secret-access.md)
* [Настройка Yandex Cloud DNS для доступа к кластеру Yandex Managed Service for ClickHouse® из других облачных сетей](clickhouse-dns-peering.md)

{% endcut %}


## Управление схемами данных {#data-management}

Schema Registry — сервис для хранения и управления схемами сообщений в форматах Avro, JSON Schema и Protobuf. Сценарии включают создание и настройку управляемого Schema Registry, работу с REST API, а также интеграцию с Confluent Schema Registry для обеспечения совместимости данных в потоковой обработке.

{% cut "Полный перечень руководств" %}

* [Управление схемами данных в Managed Service for Apache Kafka®](schema-registry-overview.md)
* [Использование Managed Schema Registry с Yandex Managed Service for Apache Kafka®](managed-schema-registry.md)
* [Использование Managed Schema Registry с Yandex Managed Service for Apache Kafka® с помощью REST API](managed-schema-registry-rest.md)
* [Использование Confluent Schema Registry с Yandex Managed Service for Apache Kafka®](confluent-schema-registry.md)

{% endcut %}


## Развертывание и настройка кластеров {#cluster-deployment}

Специализированные сценарии конфигурации и развертывания кластеров управляемых баз данных: установка веб-интерфейса Apache Kafka®, настройка веб-сервера с файлом конфигурации для работы с протоколом `s3`, инициализация в Yandex Data Processing через init-скрипты, использование кластера PostgreSQL для 1С, хранение PHP-сессий в кластере Yandex Managed Service for Valkey™, настройка Managed Service for ClickHouse® для Graphite, именованные запросы PXF и подключение лемматизатора к OpenSearch.

{% cut "Полный перечень руководств" %}

* [Самостоятельное развертывание веб-интерфейса Apache Kafka®](deploy-kafka-ui.md)
* [Создание внешней таблицы на базе таблицы из бакета Yandex Object Storage с помощью конфигурационного файла](mgp-config-server-for-s3.md)
* [Монтирование бакетов Yandex Object Storage к файловой системе хостов Yandex Data Processing](data-processing-init-actions-geesefs.md)
* [Создание кластера PostgreSQL для «1С:Предприятия»](1c-postgresql.md)
* [Использование кластера Yandex Managed Service for Valkey™ в качестве хранилища сессий PHP](valkey-as-php-sessions-storage.md)
* [Настройка Yandex Managed Service for ClickHouse® для Graphite](clickhouse-for-graphite.md)
* [Получение данных из внешних источников с помощью именованных запросов](pxf-named-queries.md)
* [Использование плагина yandex-lemmer в Yandex Managed Service for OpenSearch](opensearch-yandex-lemmer.md)
* [Подключение MCP-клиента к кластеру OpenSearch](mos-mcp.md)
* [Распределенные блокировки для 1С:Предприятия в кластере Yandex Managed Service for Valkey™](1c-valkey-locks.md)
* [Использование кластера Yandex Managed Service for Valkey™ в качестве хранилища кеша для «1С-Битрикс: Управление сайтом»](../infrastructure-management/yc-valkey-as-1c-cache-storage.md)
* [Использование Yandex Managed Service for Valkey™ с модулем Search и моделей Yandex AI Studio для векторного поиска в RAG-системе](valkey-rag-search.md)

{% endcut %}