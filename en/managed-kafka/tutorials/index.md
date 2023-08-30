# {{ mkf-name }} tutorials

You can use {{ mkf-name }} to transfer data between databases. Sources and targets can be {{ mkf-name }} clusters, third-party {{ KF }} clusters, or {{ yandex-cloud }} managed databases.

## Moving data from {{ KF }} {#moving-data}

* [Configuring {{ KFC }} for {{ mkf-name }} clusters](./kafka-connect.md)
* [{#T}](./kafka-connectors.md)
* [{#T}](./mkf-to-mkf-transfer.md)

## Using the registry of data format schemas with {{ mkf-name }} {#schema-registry}

* [Overview](./schema-registry-overview.md)
* [{#T}](./managed-schema-registry.md)
* [{#T}](./confluent-schema-registry.md)

## Delivering data using {{ data-transfer-name }} {#data-transfer}

* [From {{ PG }} to {{ KF }}](cdc/data-transfer-mpg.md)
* [From {{ KF }} to {{ PG }}](mkf-to-mpg.md)
* [{#T}](./cdc/data-transfer-ydb.md)
* [From {{ KF }} to {{ ydb-short-name }}](mkf-ydb-stream.md)
* [From {{ KF }} to {{ CH }}](mkf-to-mch-migration.md)
* [{#T}](./mkf-yds-stream.md)
* [{#T}](./mkf-to-mes-migration.md)
* [{#T}](./managed-kafka-to-greenplum.md)

## Delivering data using other methods {#another-delivery}

* [From {{ PG }} to {{ KF }} using Debezium](cdc/debezium-mpg.md)
* [From {{ MY }} to {{ KF }} using Debezium](cdc/debezium-mmy.md)
* [From {{ KF }} to {{ CH }}](send-data-to-mch.md)
* [From {{ KF }} to ksqlDB](use-ksqldb-with-mkf.md)
