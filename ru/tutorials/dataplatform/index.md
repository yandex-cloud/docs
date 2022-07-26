# Построение Data Platform на базе {{ yandex-cloud }}

## {{ KF }} {#kafka}

* [{#T}](kafka-connector.md)
* [{#T}](kafka-cdc/data-transfer-mpg.md)
* [{#T}](kafka-cdc/debezium-mmy.md)
* [{#T}](kafka-cdc/debezium-mpg.md)
* [{#T}](kafka-connect.md)
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

## {{ dns-name }} {#dns}

* [{#T}](mdb-dns-peering.md)

{% if product == "yandex-cloud" %}
## {{ dataproc-name }} {#dataproc}

* [{#T}](dp-mch-data-exchange.md)
* [{#T}](sqoop.md)
* [{#T}](data-proc-init-actions-geesefs.md).
{% endif %}

{% if product == "yandex-cloud" %}
## {{ ES }} {#elasticsearch}

* [{#T}](migration-via-reindex-api.md)
{% endif %}

{% if product == "yandex-cloud" %}
## {{ MG }} {#mongodb}

* [{#T}](mongodb-migration.md)
{% endif %}

## {{ MY }} {#mysql}

* [{#T}](mysql-data-migration.md)
* [{#T}](sync-mysql.md)
* [{#T}](mmy-to-mysql-migration.md)
{% if product == "yandex-cloud" %}
* [{#T}](sqoop.md)
{% endif %}
* [{#T}](./kafka-cdc/debezium-mmy.md)

## {{ PG }} {#postgresql}

* [{#T}](rdbms-to-clickhouse.md)
* [{#T}](./kafka-cdc/data-transfer-mpg.md)
* [{#T}](./kafka-cdc/debezium-mpg.md)
{% if product == "yandex-cloud" %}
* [{#T}](sqoop.md)
{% endif %}

## {{ RD }} {#redis}
* [{#T}](redis-data-migration.md)

{% if product == "yandex-cloud" %}
## {{ MS }} {#sqlserver}

* [{#T}](mssql-data-migration.md)
* [{#T}](mssql-outbound-migration.md)
{% endif %}
