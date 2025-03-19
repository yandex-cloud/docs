---
title: Практические руководства для построения Data Platform на базе {{ yandex-cloud }}
description: На странице представлен список практических руководств для построения Data Platform на базе {{ yandex-cloud }} с применением различных СУБД.
---

# Построение Data Platform на базе {{ yandex-cloud }}

## {{ KF }} {#kafka}

* [{#T}](deploy-kafka-ui.md)
* [{#T}](kafka-connector.md)
* [{#T}](data-transfer-mkf.md)
* [{#T}](data-transfer-mmy.md)
* [{#T}](debezium-mmy.md)
* [{#T}](data-transfer-mpg.md)
* [{#T}](debezium-mpg.md)
* [{#T}](ydb-mkf-replication.md)
* [{#T}](data-transfer-mkf-mch.md)
* [{#T}](managed-kafka-to-greenplum.md)
* [{#T}](data-transfer-mkf-mmg.md)
* [{#T}](data-transfer-mkf-mmy.md)
* [{#T}](data-transfer-mkf-mos.md)
* [{#T}](mkf-to-mpg.md)
* [{#T}](mkf-ydb-stream.md)
* [{#T}](mkf-yds-stream.md)
* [{#T}](yds-to-kafka.md)
* [{#T}](kafka-connect.md)
* Использование реестра схем форматов данных с {{ mkf-full-name }}:
  * [Управление схемами данных в {{ mkf-name }}](schema-registry-overview.md)
  * [{#T}](managed-schema-registry.md)
  * [{#T}](managed-schema-registry-rest.md)
  * [{#T}](confluent-schema-registry.md)

## {{ AF }} {#airflow}

* [{#T}](airflow-auto-tasks.md)
* [{#T}](using-python-sdk-in-airflow.md)
* [{#T}](lockbox-and-airflow.md)

## {{ CH }} {#clickhouse}

* [{#T}](insert-data-ch.md)
* [{#T}](ch-to-mch-migration.md)
* [{#T}](clickhouse-migration.md)
* [{#T}](mysql-to-clickhouse.md)
* [{#T}](rdbms-to-clickhouse.md)
* [{#T}](dp-mch-data-exchange.md)
* [{#T}](clickhouse-for-graphite.md)
* [{#T}](fetch-data-from-mkf.md)
* [{#T}](use-ksqldb-with-mkf.md)
* [{#T}](data-transfer-mkf-mch.md)
* [{#T}](fetch-data-from-rabbitmq.md)
* [{#T}](yds-to-clickhouse.md)
* [{#T}](clickhouse-hybrid-storage.md)
* [{#T}](clickhouse-sharding.md)
* [{#T}](mch-mch-resharding.md)
* [{#T}](data-transfer-direct-to-mch.md)
* [{#T}](object-storage-to-clickhouse.md)
* [{#T}](opensearch-to-clickhouse.md)
* [{#T}](ydb-to-clickhouse.md)
* [{#T}](bigquery-to-clickhouse.md)

## {{ GP }} {#greenplum}

* [{#T}](managed-kafka-to-greenplum.md)
* [{#T}](mmy-to-mgp.md)
* [{#T}](greenplum-to-clickhouse.md)
* [{#T}](greenplum-to-postgresql.md)
* [{#T}](greenplum-yezzey.md)
* [{#T}](object-storage-to-greenplum.md)


## {{ ES }} {#elasticsearch}

* [{#T}](elasticsearch-to-opensearch.md)
* [{#T}](migration-via-snapshots.md)

## {{ MG }} {#mongodb}

* [{#T}](mongodb-migration-with-data-transfer.md)
* [{#T}](mongodb-data-migration.md)
* [{#T}](mongodb-versions.md)
* [{#T}](mongodb-sharding.md)
* [{#T}](mongodb-profiling.md)
* [{#T}](data-transfer-mkf-mmg.md)


## {{ MY }} {#mysql}

* [{#T}](mysql-data-migration.md)
* [{#T}](profiling-mmy.md)
* [{#T}](sync-mysql.md)
* [{#T}](mmy-to-mysql-migration.md)
* [{#T}](data-transfer-mkf-mmy.md)
* [{#T}](mysql-to-clickhouse.md)
* [{#T}](mmy-objs-migration.md)
* [{#T}](objs-mmy-migration.md)
* [{#T}](mmy-to-yds.md)
* [{#T}](mmy-to-mpg.md)
* [{#T}](mmy-to-mgp.md)
* [{#T}](sqoop-mmy.md)
* [{#T}](data-transfer-mmy.md)
* [{#T}](debezium-mmy.md)
* [{#T}](mmy-ydb-migration.md)


## {{ OS }} {#opensearch}

* [{#T}](opensearch-index-policy.md)
* [{#T}](elasticsearch-to-opensearch.md)
* [{#T}](data-transfer-mkf-mos.md)
* [{#T}](mos-migration-from-standalone.md)
* [{#T}](opensearch-to-object-storage.md)
* [{#T}](opensearch-to-ydb.md)
* [{#T}](opensearch-to-clickhouse.md)
* [{#T}](postgresql-to-opensearch.md)
* [{#T}](opensearch-saml-keycloak.md)
* [{#T}](opensearch-yandex-lemmer.md)


## {{ PG }} {#postgresql}

* [Создание кластера {{ PG }} для «1С:Предприятия»](1c-postgresql.md)
* [Анализ производительности и оптимизация {{ mpg-name }}](mpg-profiling.md)
* [Миграция базы данных из {{ mpg-name }}](outbound-replication.md)
* [Миграция базы данных из стороннего кластера {{ PG }} в {{ mpg-name }}](postgresql-data-migration.md)
* [{#T}](rdbms-to-clickhouse.md)
* [{#T}](mkf-to-mpg.md)
* [{#T}](data-transfer-mpg.md)
* [{#T}](debezium-mpg.md)
* [{#T}](sqoop-mpg.md)
* [{#T}](mpg-ydb-replication.md)
* [{#T}](mpg-to-objstorage.md)
* [{#T}](object-storage-to-postgresql.md)
* [{#T}](mpg-to-mmy.md)
* [{#T}](mpg-to-yds.md)
* [{#T}](rds-to-mpg.md)
* [{#T}](postgresql-to-opensearch.md)


## {{ VLK }} {#redis}

* [{#T}](redis-data-migration.md)
* [{#T}](redis-as-php-sessions-storage.md)

## {{ ydb-short-name }} {#ydb}

* [{#T}](ydb-mkf-replication.md)
* [{#T}](mkf-ydb-stream.md)
* [{#T}](mmy-ydb-migration.md)
* [{#T}](mpg-ydb-replication.md)
* [{#T}](object-storage-to-ydb.md)
* [{#T}](ydb-to-object-storage.md)
* [{#T}](ydb-to-clickhouse.md)
* [{#T}](opensearch-to-ydb.md)
* [{#T}](yds-to-ydb.md)
* [{#T}](ydb-to-yds.md)

## {{ dns-full-name }} {#dns}

* [{#T}](clickhouse-dns-peering.md)

## {{ dataproc-full-name }} {#dataproc}

* [{#T}](hdfs-cluster-migration.md)
* [{#T}](dp-mch-data-exchange.md)
* [{#T}](sqoop-mmy.md)
* [{#T}](sqoop-mpg.md)
* [{#T}](data-processing-init-actions-geesefs.md)
* [{#T}](data-processing-and-kafka.md)
* [{#T}](data-processing-and-airflow.md)
* [{#T}](data-processing-to-data-processing.md)
* [{#T}](metastore-import.md)
* [{#T}](s3-data-processing-ch.md)

### Базовые примеры работы с заданиями {#jobs-basic-tutorials}

* [{#T}](hive-job-basics.md)
* [{#T}](mapreduce-job-basics.md)
* [{#T}](pyspark-job-basics.md)
* [{#T}](spark-job-basics.md)

### Продвинутые примеры работы с заданиями {#jobs-advanced-tutorials}

* [{#T}](how-to-use-hive.md)
* [{#T}](run-spark-job.md)
* [{#T}](remote-run-job.md)

## {{ yq-full-name }} {#query}

* [{#T}](audit-log-processing.md)
* [{#T}](cloud-logging-processing.md)
* [{#T}](debezium-yq.md)
* [{#T}](jupyter-yq.md)
* [{#T}](billing-detail-files-processing.md)

## {{ yds-full-name }} {#yds}

* [{#T}](data-ingestion.md)
* [{#T}](log-ingestion.md)
* [{#T}](message-broker.md)
* [{#T}](yds-obj-migration.md)

## {{ data-transfer-full-name }} {#data-transfer}

* [{#T}](managed-greenplum.md)
* [{#T}](managed-mongodb.md)
* [{#T}](managed-mysql.md)
* [{#T}](managed-mysql-to-mysql.md)
* [{#T}](managed-postgresql.md)
* [{#T}](schema-registry-cdc-debezium-kafka.md)

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}