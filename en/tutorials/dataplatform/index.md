# Building a data platform on {{ yandex-cloud }}

* [Syncing {{ MY }} data using {{ data-transfer-full-name }}](sync-mysql.md)
* Using the registry of data format schemas with Managed Service for Apache Kafka®:
   * [Managing data schemas](schema-registry-overview.md)
   * [Working with the managed registry of data format schemas](managed-schema-registry.md)
   * [Working with Confluent Schema Registry](confluent-schema-registry.md)
* [Migrating databases from {{ mmy-full-name }} to {{ MY }}](mmy-to-mysql-migration.md)
* [Configuring a managed database in a {{ CH }} cluster for Graphite](clickhouse-for-graphite.md)
{% if product == "yandex-cloud" %}
* [Exchanging data between {{ mch-name }} and {{ dataproc-full-name }}](dp-mch-data-exchange.md)
{% endif %}
* [Using Confluent Schema Registry with {{ mkf-name }}](confluent-schema-registry.md)
* [Configuring Kafka Connect for {{ mkf-name }} clusters](kafka-connect.md)
* [{#T}](kafka-cdc.md)
* [{#T}](./kafka-cdc-data-transfer.md)
{% if product == "yandex-cloud" %}
* [Using Confluent Schema Registry with {{ mkf-name }}](confluent-schema-registry.md)
* [Configuring Kafka Connect for {{ mkf-name }} clusters](kafka-connect.md)
* [{#T}](kafka-cdc.md)
* [{#T}](./kafka-cdc-data-transfer.md)
* [Migrating databases to {{ mms-name }}](mssql-data-migration.md)
{% endif %}
* [Migrating data from {{ PG }} to {{ CH }} using {{ data-transfer-full-name }}](rdbms-to-clickhouse.md)
* [Configuring {{ dns-full-name }} for access to managed database clusters from other cloud networks](mdb-dns-peering.md)
{% if product == "yandex-cloud" %}
* [Configuring GeeseFS in {{ dataproc-full-name }} using initialization actions](./data-proc-init-actions-geesefs.md).
* [{#T}](migration-via-reindex-api.md)
{% endif %}
* [{#T}](mysql-data-migration.md)