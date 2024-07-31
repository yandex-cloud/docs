---
title: "Практические руководства для построения Data Platform на базе {{ yandex-cloud }}"
description: "На странице представлен список практических руководств для построения Data Platform на базе {{ yandex-cloud }} с применением различных СУБД."
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
* [{#T}](kafka-connect.md)
* Использование реестра схем форматов данных с {{ mkf-full-name }}:
  * [Управление схемами данных в {{ mkf-name }}](schema-registry-overview.md)
  * [{#T}](managed-schema-registry.md)
  * [{#T}](confluent-schema-registry.md)

## {{ AF }} {#airflow}

* [{#T}](airflow-auto-tasks.md)
* [{#T}](using-python-sdk-in-airflow.md)
* [{#T}](lockbox-and-airflow.md)

## {{ CH }} {#clickhouse}

* [{#T}](mysql-to-clickhouse.md)
* [{#T}](rdbms-to-clickhouse.md)
* [{#T}](dp-mch-data-exchange.md)
* [{#T}](clickhouse-for-graphite.md)
* [{#T}](fetch-data-from-mkf.md)
* [{#T}](data-transfer-mkf-mch.md)
* [{#T}](fetch-data-from-rabbitmq.md)
* [{#T}](yds-to-clickhouse.md)
* [{#T}](clickhouse-hybrid-storage.md)
* [{#T}](clickhouse-sharding.md)
* [{#T}](mch-mch-resharding.md)
* [{#T}](data-transfer-direct-to-mch.md)
* [{#T}](object-storage-to-clickhouse.md)
* [{#T}](ydb-to-clickhouse.md)

## {{ GP }} {#greenplum}

* [{#T}](managed-kafka-to-greenplum.md)
* [{#T}](mmy-to-mgp.md)
* [{#T}](greenplum-to-clickhouse.md)
* [{#T}](greenplum-to-postgresql.md)
* [{#T}](greenplum-yezzey.md)
* [{#T}](object-storage-to-greenplum.md)


## {{ ES }} {#elasticsearch}

* [{#T}](elasticsearch-to-opensearch.md)

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

* [{#T}](elasticsearch-to-opensearch.md)
* [{#T}](data-transfer-mkf-mos.md)
* [{#T}](mos-migration-from-standalone.md)


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


## {{ RD }} {#redis}

* [{#T}](redis-data-migration.md)
* [{#T}](redis-as-php-sessions-storage.md)

## {{ ydb-short-name }} {#ydb}

* [{#T}](ydb-mkf-replication.md)
* [{#T}](mkf-ydb-stream.md)
* [{#T}](mmy-ydb-migration.md)
* [{#T}](mpg-ydb-replication.md)
* [{#T}](object-storage-to-ydb.md)
* [{#T}](ydb-to-clickhouse.md)

## {{ dns-full-name }} {#dns}

* [{#T}](clickhouse-dns-peering.md)

## {{ dataproc-full-name }} {#dataproc}

* [{#T}](hdfs-cluster-migration.md)
* [{#T}](dp-mch-data-exchange.md)
* [{#T}](sqoop-mmy.md)
* [{#T}](sqoop-mpg.md)
* [{#T}](data-proc-init-actions-geesefs.md)
* [{#T}](data-proc-and-airflow.md)
* [{#T}](metastore-import.md)


{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
