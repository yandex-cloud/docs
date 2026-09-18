---
title: Практические руководства для построения Data Platform на базе {{ yandex-cloud }}
description: На странице представлен список практических руководств для построения Data Platform на базе {{ yandex-cloud }} с применением различных СУБД.
---


# Построение Data Platform на базе {{ yandex-cloud }}


## Миграция данных и обновление версий СУБД {#migration}

Миграция — задача, в рамках которой требуется перенести данные из одного хранилища в другое: из локальных баз в управляемые облачные, между кластерами или со сменой типа СУБД. Практические руководства в этой группе описывают сценарии переноса для {{ MY }}, {{ PG }}, {{ CH }}, {{ GP }}, {{ MG }}, {{ ydb-short-name }}, {{ OS }} и других систем, а также обновление версий баз данных с минимальным простоем.

{% cut "Полный перечень руководств" %}

* [{#T}](rdbms-to-clickhouse.md)
* [{#T}](mysql-data-migration/index.md)
* [{#T}](postgresql-data-migration.md)
* [{#T}](valkey-data-migration.md)
* [{#T}](mmy-to-mysql-migration.md)
* [{#T}](mysql-to-clickhouse.md)
* [{#T}](greenplum-to-postgresql.md)
* [{#T}](clickhouse-migration.md)
* [{#T}](ch-to-mch-migration.md)
* [{#T}](mos-migration-from-standalone.md)
* [{#T}](mos-migration-from-standalone.md)
* [{#T}](storedoc-data-migration.md)
* [{#T}](yds-obj-migration.md)
* [{#T}](rds-to-mpg.md)
* [{#T}](mmy-to-mgp.md)
* [{#T}](mmy-to-mpg.md)
* [{#T}](mpg-to-mmy.md)
* [{#T}](mmy-to-mgp.md)
* [{#T}](mmy-to-mpg.md)
* [{#T}](mpg-to-mmy.md)
* [{#T}](ydb-to-postgresql.md)
* [{#T}](objs-mmy-migration.md)
* [{#T}](bigquery-to-clickhouse.md)
* [{#T}](mmy-ydb-migration.md)
* [{#T}](mmy-objs-migration.md)
* [{#T}](greenplum-to-clickhouse.md)
* [{#T}](postgresql-versions.md)
* [{#T}](storedoc-versions.md)
* [{#T}](hdfs-cluster-migration.md)
* [{#T}](zk-kraft-kafka-migration.md)

{% endcut %}


## Репликация и потоковый захват изменений данных {#replication}

Репликация и CDC (Change Data Capture) — процессы непрерывного отслеживания изменений в источнике и их доставки в приемник в режиме реального времени. Практические руководства этой группы описывают настройку репликации между кластерами, а также захват изменений с помощью Debezium и поставку потоков данных в системы-приемники.

{% cut "Полный перечень руководств" %}

* [{#T}](debezium-mmy.md)
* [{#T}](debezium-mpg.md)
* [{#T}](mpg-ydb-replication.md)
* [{#T}](ydb-mkf-replication.md)
* [{#T}](debezium-yq.md)
* [{#T}](sync-mysql.md)
* [{#T}](outbound-replication.md)
* [{#T}](mpg-replication-overview.md)
* [{#T}](schema-registry-cdc-debezium-kafka.md)

{% endcut %}


## Загрузка и поставка данных {#loading-delivery}

Практические руководства описывают архитектурные шаблоны для построения потоков данных: от источников (внешние базы, файлы, логи, брокеры) к хранилищам и обратно. Рассмотрены сценарии потоковой передачи через {{ DS }}, доставки событий из {{ KF }} и {{ RMQ }}, пакетной загрузки и сквозного трансфера с помощью {{ data-transfer-name }}. 

{% cut "Полный перечень руководств" %}

* [{#T}](data-ingestion.md)
* [{#T}](log-ingestion.md)
* [{#T}](message-broker.md)
* [{#T}](insert-data-ch.md)
* [{#T}](fetch-data-from-mkf.md)
* [{#T}](fetch-data-from-rabbitmq.md)
* [{#T}](use-ksqldb-with-mkf.md)
* [{#T}](yds-to-kafka.md)
* [{#T}](mkf-yds-stream.md)
* [{#T}](mkf-ydb-stream.md)
* [{#T}](yds-to-clickhouse.md)
* [{#T}](yds-to-ydb.md)
* [{#T}](ydb-to-yds.md)
* [{#T}](mkf-to-mpg.md)
* [{#T}](managed-kafka-to-greenplum.md)
* [{#T}](kafka-connector.md)
* [{#T}](kafka-connect.md)
* [{#T}](data-transfer-mkf.md)
* [{#T}](data-transfer-mmy.md)
* [{#T}](data-transfer-mpg.md)
* [{#T}](data-transfer-mkf-mch.md)
* [{#T}](data-transfer-mkf-mmg.md)
* [{#T}](data-transfer-mkf-mmy.md)
* [{#T}](data-transfer-mkf-mos.md)
* [{#T}](data-transfer-direct-to-mch.md)
* [{#T}](managed-greenplum.md)
* [{#T}](managed-mysql.md)
* [{#T}](managed-mysql-to-mysql.md)
* [{#T}](managed-postgresql.md)
* [{#T}](storedoc.md)
* [{#T}](mmy-to-yds.md)
* [{#T}](mpg-to-yds.md)

{% endcut %}


## Интеграция и обмен между системами хранения и обработки данных {#integration}

Руководства этой группы описывают двусторонний обмен данными между разнородными хранилищами и вычислительными системами: {{ CH }}, {{ GP }}, {{ PG }}, {{ ydb-short-name }}, {{ OS }}, {{ objstorage-name }} и внешними СУБД через JDBC. Сценарии включают поставку данных из аналитических кластеров в реляционные базы данных, обмен между {{ objstorage-name }} и сервисами управляемых баз данных, а также интеграцию {{ OS }} с другими хранилищами.

{% cut "Полный перечень руководств" %}

* [{#T}](dp-mch-data-exchange.md)
* [{#T}](data-processing-to-data-processing.md)
* [{#T}](s3-data-processing-ch.md)
* [{#T}](data-processing-and-kafka.md)
* [{#T}](jdbc-ch-to-sql-server-integration.md)
* [{#T}](jdbc-ch-to-oracle-integration.md)
* [{#T}](spark-objstorage-integration.md)
* [{#T}](mpg-pg-clickhouse-extension.md)
* [{#T}](object-storage-to-clickhouse.md)
* [{#T}](object-storage-to-greenplum.md)
* [{#T}](object-storage-to-postgresql.md)
* [{#T}](object-storage-to-ydb.md)
* [{#T}](opensearch-to-clickhouse.md)
* [{#T}](opensearch-to-greenplum.md)
* [{#T}](opensearch-to-ydb.md)
* [{#T}](opensearch-to-object-storage.md)
* [{#T}](postgresql-to-opensearch.md)
* [{#T}](ydb-to-clickhouse.md)
* [{#T}](mpg-to-objstorage.md)
* [{#T}](ydb-to-object-storage.md)

{% endcut %}


## Аналитические вычисления {#analytical}

Руководства по запуску аналитических задач: {{ SPRK }}, PySpark, {{ metastore-name }}, MapReduce. Сюда входят сценарии удаленного запуска задач, чтения и записи данных, интеграции {{ SPRK }} с {{ metastore-name }} и {{ ml-platform-short-name }}, а также загрузки данных из реляционных источников через Sqoop.

{% cut "Полный перечень руководств" %}

* [{#T}](hive-job-basics.md)
* [{#T}](mapreduce-job-basics.md)
* [{#T}](pyspark-job-basics.md)
* [{#T}](spark-job-basics.md)
* [{#T}](how-to-use-hive.md)
* [{#T}](run-spark-job.md)
* [{#T}](remote-run-job.md)
* [{#T}](spark-simple-rw-job.md)
* [{#T}](yt-run-spark-job.md)
* [{#T}](metastore-and-spark.md)
* [{#T}](metastore-import.md)
* [{#T}](spark-and-datasphere.md)
* [{#T}](sqoop-mmy.md)
* [{#T}](sqoop-mpg.md)

{% endcut %}


## Оркестрация пайплайнов {#pipeline-orchestration}

Руководства по описанию автоматизации и планированию выполнения задач обработки данных с помощью {{ AF }}. Сценарии включают автоматический запуск задач, использование Python SDK внутри DAG, совместный запуск {{ AF }} и {{ SPRK }}, а также настройку уведомлений по почте при сбоях в пайплайнах.

{% cut "Полный перечень руководств" %}

* [{#T}](airflow-auto-tasks.md)
* [{#T}](using-python-sdk-in-airflow.md)
* [{#T}](airflow-and-spark.md)
* [{#T}](airflow-spark-min.md)
* [{#T}](data-processing-and-airflow.md)
* [{#T}](airflow-test-smtp-notification.md)

{% endcut %}


## Хранение, архивация, жизненный цикл данных {#storage-archiving}

Руководства по управлению жизненным циклом данных в хранилищах: гибридное хранение, шардирование, политики холодного хранения и ротации индексов в {{ OS }}, настройка retention-политик, архивация данных.

{% cut "Полный перечень руководств" %}

* [{#T}](clickhouse-hybrid-storage.md)
* [{#T}](clickhouse-sharding.md)
* [{#T}](storedoc-sharding.md)
* [{#T}](opensearch-cold-storage-policy.md)
* [{#T}](opensearch-index-policy.md)
* [{#T}](greenplum-yezzey.md)
* [{#T}](retention-policy.md)
* [{#T}](kafka-topic-s3-sync-private.md)

{% endcut %}


## Производительность и диагностика {#productivity-diagnostics}

Диагностика узких мест, профилирование и устранение проблем производительности в СУБД и сервисах обработки. Сценарии помогут быстро локализовать и исправить проблемы с нагрузкой и скоростью выполнения запросов.

{% cut "Полный перечень руководств" %}

* [{#T}](mpg-performance-problems.md)
* [{#T}](mpg-profiling.md)
* [{#T}](profiling-mmy.md)
* [{#T}](storedoc-profiling.md)
* [{#T}](postgresql-glibc-collation-issues.md)

{% endcut %}


## Мониторинг, логи, аудит, биллинг {#monitoring-logs}

Руководства по обработке и анализу различных видов телеметрии: аудитных логов, логов {{ cloud-logging-name }}, детализированных файлов биллинга, а также настройки уведомлений из {{ OS }} и работы с Jupyter Notebook в связке с {{ yq-full-name }}.

{% cut "Полный перечень руководств" %}

* [{#T}](audit-log-processing.md)
* [{#T}](cloud-logging-processing.md)
* [{#T}](billing-detail-files-processing.md)
* [{#T}](opensearch-email-notifications.md)
* [{#T}](jupyter-yq.md)

{% endcut %}


## Безопасность и доступы {#security-and-access}

Сценарии настройки безопасного доступа к ресурсам платформы данных: аутентификация в {{ OS }} через SAML и Keycloak, управление секретами при запуске PySpark‑задач и через {{ connection-manager-name }}, а также настройка DNS-peering для частной сети {{ CH }}.

{% cut "Полный перечень руководств" %}

* [{#T}](opensearch-saml-keycloak.md)
* [{#T}](job-pyspark-secret-access.md)
* [{#T}](conn-man-secret-access.md)
* [{#T}](clickhouse-dns-peering.md)

{% endcut %}


## Управление схемами данных {#data-management}

{{ schema-registry-name }} — сервис для хранения и управления схемами сообщений в форматах Avro, JSON Schema и Protobuf. Сценарии включают создание и настройку управляемого {{ schema-registry-name }}, работу с REST API, а также интеграцию с Confluent Schema Registry для обеспечения совместимости данных в потоковой обработке.

{% cut "Полный перечень руководств" %}

* [{#T}](schema-registry-overview.md)
* [{#T}](managed-schema-registry.md)
* [{#T}](managed-schema-registry-rest.md)
* [{#T}](confluent-schema-registry.md)

{% endcut %}


## Развертывание и настройка кластеров {#cluster-deployment}

Специализированные сценарии конфигурации и развертывания кластеров управляемых баз данных: установка веб-интерфейса {{ KF }}, настройка веб-сервера с файлом конфигурации для работы с протоколом `s3`, инициализация в {{ dataproc-short-name }} через init-скрипты, использование кластера {{ PG }} для 1С, хранение PHP-сессий в кластере {{ mrd-name }}, настройка {{ mch-name }} для Graphite, именованные запросы PXF и подключение лемматизатора к {{ OS }}.

{% cut "Полный перечень руководств" %}

* [{#T}](deploy-kafka-ui.md)
* [{#T}](mgp-config-server-for-s3.md)
* [{#T}](data-processing-init-actions-geesefs.md)
* [{#T}](1c-postgresql.md)
* [{#T}](valkey-as-php-sessions-storage.md)
* [{#T}](clickhouse-for-graphite.md)
* [{#T}](pxf-named-queries.md)
* [{#T}](opensearch-yandex-lemmer.md)
* [{#T}](mos-mcp.md)
* [{#T}](1c-valkey-locks.md)
* [{#T}](../infrastructure-management/yc-valkey-as-1c-cache-storage.md)
* [{#T}](valkey-rag-search.md)

{% endcut %}
