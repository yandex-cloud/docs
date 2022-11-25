# {{ mpg-name }} practical guidelines

* [Creating a {{ PG }} cluster for <q>1C:Enterprise</q>](./1c-postgresql.md)
{% if audience != "internal" and product == "yandex-cloud" %}
* [{#T}](./sqoop.md)
{% endif %}
* [{#T}](./profiling.md)
* [{#T}](./cdc-data-transfer.md)
* [{#T}](./cdc-debezium.md)

## Replication and migration {#replication-and-migration}

* [{#T}](./replication-overview.md)
* [{#T}](./data-migration.md)
* [{#T}](./outbound-replication.md)
{% if audience != "internal" %}
* [{#T}](../operations/logical-replica-from-rds.md)
{% endif %}
