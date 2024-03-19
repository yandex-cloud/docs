---
title: "Tutorials for building a data platform based on {{ yandex-cloud }}"
description: "This page provides a list of tutorials for building a data platform based on {{ yandex-cloud }} using various DBMS."
---

# Building a data platform based on {{ yandex-cloud }}

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
* [{#T}](data-transfer-mkf-mes.md)
* [{#T}](data-transfer-mkf-mmg.md)
* [{#T}](data-transfer-mkf-mmy.md)
* [{#T}](data-transfer-mkf-mos.md)
* [{#T}](mkf-to-mpg.md)
* [{#T}](mkf-ydb-stream.md)
* [{#T}](mkf-yds-stream.md)
* [{#T}](kafka-connect.md)
* Using the registry of data format schemas with {{ mkf-full-name }}:
  * [Managing data schemas in {{ mkf-name }}](schema-registry-overview.md)
  * [{#T}](managed-schema-registry.md)
  * [{#T}](confluent-schema-registry.md)

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
* [{#T}](data-transfer-direct-to-mch.md)
* [{#T}](object-storage-to-clickhouse.md)

## {{ GP }} {#greenplum}

* [{#T}](managed-kafka-to-greenplum.md)
* [{#T}](mmy-to-mgp.md)
* [{#T}](greenplum-to-clickhouse.md)
* [{#T}](greenplum-to-postgresql.md)
* [{#T}](greenplum-yezzey.md)


## {{ ES }} {#elasticsearch}

* [{#T}](migration-via-reindex-api.md)
* [{#T}](elasticsearch-to-opensearch.md)
* [{#T}](data-transfer-mkf-mes.md)

## {{ MG }} {#mongodb}

* [{#T}](mongodb-migration-with-data-transfer.md)
* [{#T}](mongodb-data-migration.md)
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

* [Creating a {{ PG }} cluster for 1C:Enterprise](1c-postgresql.md)
* [{{ mpg-name }} performance analysis and tuning](mpg-profiling.md)
* [Migrating databases from {{ mpg-name }}](outbound-replication.md)
* [Migrating a database from a third-party {{ PG }} cluster to {{ mpg-name }}](postgresql-data-migration.md)
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

## {{ dns-full-name }} {#dns}

* [{#T}](clickhouse-dns-peering.md)

## {{ dataproc-full-name }} {#dataproc}

* [{#T}](dp-mch-data-exchange.md)
* [{#T}](sqoop-mmy.md)
* [{#T}](sqoop-mpg.md)
* [{#T}](data-proc-init-actions-geesefs.md)
* [{#T}](data-proc-and-airflow.md)


{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
