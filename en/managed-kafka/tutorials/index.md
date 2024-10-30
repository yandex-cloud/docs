# {{ mkf-name }} tutorials

You can use {{ mkf-name }} to transfer data between databases. Sources and targets can be {{ mkf-name }} clusters, third-party {{ KF }} clusters, or {{ yandex-cloud }} managed databases.

## Moving data from {{ KF }} {#moving-data}

* [Configuring {{ KFC }} for {{ mkf-name }} clusters](./kafka-connect.md)
* [{#T}](./kafka-connectors.md)
* [{#T}](./mkf-to-mkf-transfer.md)

## Using the registry of data format schemas with {{ mkf-name }} {#schema-registry}

* [{#T}](./schema-registry-overview.md)
* [{#T}](./managed-schema-registry.md)
* [{#T}](./confluent-schema-registry.md)

## Delivering data using {{ data-transfer-name }} {#data-transfer}

* [From {{ PG }} to {{ KF }}](cdc/data-transfer-mpg.md)
* [From {{ KF }} to {{ PG }}](mkf-to-mpg.md)
* [From {{ ydb-short-name }} to {{ KF }}](cdc/data-transfer-ydb.md)
* [From {{ KF }} to {{ ydb-short-name }}](mkf-ydb-stream.md)
* [From {{ KF }} to {{ CH }}](mkf-to-mch-migration.md)
* [From {{ KF }} to {{ yds-name }}](mkf-yds-stream.md)
* [From {{ KF }} to {{ GP }}](managed-kafka-to-greenplum.md)
* [From {{ KF }} to {{ MG }}](mkf-to-mmg-migration.md)
* [From {{ MY }} to {{ KF }}](cdc/cdc-mmy.md)
* [From {{ KF }} to {{ MY }}](mkf-to-mmy-migration.md)
* [From {{ KF }} to {{ OS }}](mkf-to-mos-migration.md)

## Delivering data using other methods {#another-delivery}

* [From {{ PG }} to {{ KF }} using Debezium](cdc/debezium-mpg.md)
* [From {{ MY }} to {{ KF }} using Debezium](cdc/debezium-mmy.md)
* [From {{ KF }} to {{ CH }}](send-data-to-mch.md)
* [From {{ KF }} to ksqlDB](use-ksqldb-with-mkf.md)

## Other {#other}

* [{#T}](deploy-kafka-ui.md)


* [{#T}](data-proc.md)


{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
