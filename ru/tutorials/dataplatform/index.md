# Построение Data Platform на базе {{ yandex-cloud }}

## {{ KF }} {#kafka}

* [{#T}](kafka-connector.md)
* [{#T}](data-transfer-mmy.md)
* [{#T}](data-transfer-mpg.md)
* [{#T}](data-transfer-mkf-mch.md)
* [{#T}](debezium-mmy.md)
* [{#T}](debezium-mpg.md)
* [{#T}](kafka-connect.md)
* [{#T}](mkf-ydb-stream.md)
* Использование реестра схем форматов данных с {{ mkf-name }}:

    * [Управление схемами данных](schema-registry-overview.md)
    * [{#T}](managed-schema-registry.md)
    * [{#T}](confluent-schema-registry.md)

## {{ CH }} {#clickhouse}

* [{#T}](rdbms-to-clickhouse.md)
{% if product == "yandex-cloud" %}
* [{#T}](dp-mch-data-exchange.md)
{% endif %}
* [{#T}](clickhouse-for-graphite.md)
* [{#T}](fetch-data-from-mkf.md)
* [{#T}](data-transfer-mkf-mch.md)
* [{#T}](fetch-data-from-rabbitmq.md)
* [{#T}](clickhouse-hybrid-storage.md)
* [{#T}](clickhouse-sharding.md)
* [{#T}](yds-to-clickhouse.md)

## {{ dns-name }} {#dns}

* [{#T}](mdb-dns-peering.md)
* [{#T}](clickhouse-dns-peering.md)

{% if product == "yandex-cloud" %}
## {{ dataproc-name }} {#dataproc}

* [{#T}](dp-mch-data-exchange.md)
* [{#T}](sqoop-mmy.md)
* [{#T}](sqoop-mpg.md)
* [{#T}](data-proc-init-actions-geesefs.md)
{% endif %}

{% if product == "yandex-cloud" %}
## {{ ES }} {#elasticsearch}

* [{#T}](migration-via-reindex-api.md)
{% endif %}

{% if product == "yandex-cloud" %}
## {{ MG }} {#mongodb}

* [{#T}](mongodb-migration-with-data-transfer.md)
* [{#T}](mongodb-data-migration.md)
* [{#T}](mongodb-sharding.md)
* [{#T}](mongodb-profiling.md)
{% endif %}

## {{ MY }} {#mysql}

* [{#T}](mysql-data-migration.md)
* [{#T}](profiling-mmy.md)
* [{#T}](sync-mysql.md)
* [{#T}](mmy-to-mysql-migration.md)
* [{#T}](mmy-objs-migration.md)
{% if product == "yandex-cloud" %}
* [{#T}](sqoop-mmy.md)
{% endif %}
* [{#T}](./data-transfer-mmy.md)
* [{#T}](./debezium-mmy.md)
* [{#T}](./mmy-ydb-migration.md)

## {{ PG }} {#postgresql}

* [Создание кластера {{ PG }} для <q>1С:Предприятия</q>](1c-postgresql.md)
* [{#T}](mpg-profiling.md)
* [{#T}](outbound-replication.md)
* [{#T}](postgresql-data-migration.md)
* [{#T}](rdbms-to-clickhouse.md)
* [{#T}](./data-transfer-mpg.md)
* [{#T}](./debezium-mpg.md)
{% if product == "yandex-cloud" %}
* [{#T}](sqoop-mpg.md)
{% endif %}

## {{ GP }} {#greenplum}

* [{#T}](greenplum-to-clickhouse.md)
* [{#T}](greenplum-to-postgresql.md)

{% if product == "yandex-cloud" %}

## {{ RD }} {#redis}
* [{#T}](redis-data-migration.md)
* [{#T}](redis-as-php-sessions-storage.md)

{% endif %}


{% if product == "yandex-cloud" %}
## {{ MS }} {#sqlserver}

* [{#T}](mssql-data-migration.md)
* [{#T}](mssql-outbound-migration.md)
{% endif %}
