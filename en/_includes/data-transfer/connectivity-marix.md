Possible source and target combinations:

{% if product == "yandex-cloud" %}

{% if audience == "external" %}

| Source \ Target | [{{ KF }}](../../data-transfer/operations/endpoint/target/kafka.md) | [{{ CH }}](../../data-transfer/operations/endpoint/target/clickhouse.md) | [{{ GP }}](../../data-transfer/operations/endpoint/target/greenplum.md) | [{{ MG }}](../../data-transfer/operations/endpoint/target/mongodb.md) | [{{ MY }}](../../data-transfer/operations/endpoint/target/mysql.md) | [{{ PG }}](../../data-transfer/operations/endpoint/target/postgresql.md) | [{{ ydb-short-name }}](../../data-transfer/operations/endpoint/target/yandex-database.md) | [{{ objstorage-name }}](../../data-transfer/operations/endpoint/target/object-storage.md) | Source / Target |
|:-------------------------------------------------------------------------------------:|:-------------------------------------------------------------------:|:------------------------------------------------------------------------:|:-----------------------------------------------------------------------:|:---------------------------------------------------------------------:|:-------------------------------------------------------------------:|:------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------:|
| [Airbyte®](#airbyte) | - | C^1^ | - | C^1^ | C^1^ | C^1^ | C^1^ | - | [Airbyte®](#airbyte) |
| [{{ KF }}](../../data-transfer/operations/endpoint/source/kafka.md) | [R^1^](../../data-transfer/tutorials/mkf-to-mkf.md) | [R^1^](../../data-transfer/tutorials/mkf-to-mch.md) | R^1^ | - | - | - | [R^1^](../../data-transfer/tutorials/mkf-to-ydb.md) | R^1^ | [{{ KF }}](../../data-transfer/operations/endpoint/source/kafka.md) |
| [{{ CH }}](../../data-transfer/operations/endpoint/source/clickhouse.md) | - | [C](../../data-transfer/tutorials/managed-clickhouse.md) | - | - | - | - | - | - | [{{ CH }}](../../data-transfer/operations/endpoint/source/clickhouse.md) |
| [{{ GP }}](../../data-transfer/operations/endpoint/source/greenplum.md) | - | [C](../../data-transfer/tutorials/greenplum-to-clickhouse.md) | [C^1^](../../data-transfer/tutorials/managed-greenplum.md) | - | - | [C^1^](../../data-transfer/tutorials/greenplum-to-postgresql.md) | - | - | [{{ GP }}](../../data-transfer/operations/endpoint/source/greenplum.md) |
| [{{ MG }}](../../data-transfer/operations/endpoint/source/mongodb.md) | - | - | - | [CR](../../data-transfer/tutorials/managed-mongodb.md) | - | - | - | C^1^ | [{{ MG }}](../../data-transfer/operations/endpoint/source/mongodb.md) |
| [{{ MY }}](../../data-transfer/operations/endpoint/source/mysql.md) | [CR](../../data-transfer/tutorials/cdc-mmy.md) | CR | - | - | [C](../../data-transfer/tutorials/managed-mysql.md)R | - | [CR^1^](../../data-transfer/tutorials/managed-mysql-to-ydb.md) | [C^1^](../../data-transfer/tutorials/mmy-objs-migration.md) | [{{ MY }}](../../data-transfer/operations/endpoint/source/mysql.md) |
| [Oracle](../../data-transfer/operations/endpoint/source/oracle.md) | - | CR^1^ | - | - | - | CR^1^ | - | - | [Oracle](../../data-transfer/operations/endpoint/source/oracle.md) |
| [{{ PG }}](../../data-transfer/operations/endpoint/source/postgresql.md) | [CR](../../data-transfer/tutorials/cdc-mpg.md) | [CR](../../data-transfer/tutorials/rdbms-to-clickhouse.md) | [C^1^](../../data-transfer/tutorials/managed-greenplum.md) | - | - | [C](../../data-transfer/tutorials/managed-postgresql.md)R | [CR^1^](../../data-transfer/tutorials/mpg-to-ydb.md) | [C^1^](../../data-transfer/tutorials/mpg-to-objstorage.md) | [{{ PG }}](../../data-transfer/operations/endpoint/source/postgresql.md) |
| [{{ ydb-short-name }}](../../data-transfer/operations/endpoint/source/ydb.md) | - | C^1^ | - | - | - | - | - | C^1^ | [{{ ydb-short-name }}](../../data-transfer/operations/endpoint/source/ydb.md) |
| [{{ yds-full-name }}](../../data-transfer/operations/endpoint/source/data-streams.md) | - | [R^1^](../../data-transfer/tutorials/yds-to-clickhouse.md) | R^1^ | R^1^ | - | R^1^ | R^1^ | [R^1^](../../data-transfer/tutorials/yds-to-objstorage.md) | [{{ yds-full-name }}](../../data-transfer/operations/endpoint/source/data-streams.md) |

{% else %}

| Source \ Target | [{{ KF }}](../../data-transfer/operations/endpoint/target/kafka.md) | [{{ CH }}](../../data-transfer/operations/endpoint/target/clickhouse.md) | [{{ GP }}](../../data-transfer/operations/endpoint/target/greenplum.md) | [Logbroker](../../data-transfer/operations/endpoint/target/logbroker.md) | [Logfeller](../../data-transfer/operations/endpoint/target/logfeller.md) | [{{ MG }}](../../data-transfer/operations/endpoint/target/mongodb.md) | [{{ MY }}](../../data-transfer/operations/endpoint/target/mysql.md) | [{{ PG }}](../../data-transfer/operations/endpoint/target/postgresql.md) | [{{ ydb-name }}](../../data-transfer/operations/endpoint/target/yandex-database.md) | [{{ objstorage-name }}](../../data-transfer/operations/endpoint/target/object-storage.md) | [YT](../../data-transfer/operations/endpoint/target/yt.md) | Source / Target |
|:-------------------------------------------------------------------------------------:|:-------------------------------------------------------------------:|:------------------------------------------------------------------------:|:-----------------------------------------------------------------------:|:------------------------------------------------------------------------:|:------------------------------------------------------------------------:|:---------------------------------------------------------------------:|:-------------------------------------------------------------------:|:------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------:|:----------------------------------------------------------:|:-------------------------------------------------------------------------------------:|
| [Airbyte®](#airbyte) | - | C^1^ | - | C^1^ | - | C^1^ | C^1^ | C^1^ | C^1^ | - | - | [Airbyte®](#airbyte) |
| [{{ KF }}](../../data-transfer/operations/endpoint/source/kafka.md) | [R^1^](../../data-transfer/tutorials/mkf-to-mkf.md) | [R^1^](../../data-transfer/tutorials/mkf-to-mch.md) | - | R^1^ | - | R^1^ | R^1^ | R^1^ | [R^1^](../../data-transfer/tutorials/mkf-to-ydb.md) | R^1^ | R^1^ | [{{ KF }}](../../data-transfer/operations/endpoint/source/kafka.md) |
| [{{ CH }}](../../data-transfer/operations/endpoint/source/clickhouse.md) | - | [C^1^](../../data-transfer/tutorials/managed-clickhouse.md) | - | - | - | - | - | - | - | - | C^1^ | [{{ CH }}](../../data-transfer/operations/endpoint/source/clickhouse.md) |
| [EventHub](../../data-transfer/operations/endpoint/source/eventhub.md) | R^1^ | R^1^ | - | R^1^ | R^1^ | R^1^ | R^1^ | R^1^ | R^1^ | R^1^ | R^1^ | [EventHub](../../data-transfer/operations/endpoint/source/eventhub.md) |
| [{{ GP }}](../../data-transfer/operations/endpoint/source/greenplum.md) | - | [C](../../data-transfer/tutorials/greenplum-to-clickhouse.md) | C^1^ | - | - | - | - | C^1^ | - | - | C^1^ | [{{ GP }}](../../data-transfer/operations/endpoint/source/greenplum.md) |
| [Logbroker](../../data-transfer/operations/endpoint/source/logbroker.md) | P | P | - | P | - | P | P | P | P | P | P | [Logbroker](../../data-transfer/operations/endpoint/source/logbroker.md) |
| [Logfeller](../../data-transfer/operations/endpoint/source/logfeller.md) | P | P | - | P | P | P | P | P | P | - | P | [Logfeller](../../data-transfer/operations/endpoint/source/logfeller.md) |
| [{{ MG }}](../../data-transfer/operations/endpoint/source/mongodb.md) | R^1^ | CR^1^ | - | CR | - | [CR](../../data-transfer/tutorials/managed-mongodb.md) | - | - | CR^1^ | C^1^ | CR | [{{ MG }}](../../data-transfer/operations/endpoint/source/mongodb.md) |
| [{{ MY }}](../../data-transfer/operations/endpoint/source/mysql.md) | [R^1^](../../data-transfer/tutorials/cdc-mmy.md) | CR^1^ | - | CR | - | CR^1^ | [C](../../data-transfer/tutorials/managed-mysql.md)R | - | [CR^1^](../../data-transfer/tutorials/managed-mysql-to-ydb.md) | [C^1^](../../data-transfer/tutorials/mmy-objs-migration.md) | CR | [{{ MY }}](../../data-transfer/operations/endpoint/source/mysql.md) |
| [Oracle](../../data-transfer/operations/endpoint/source/oracle.md) | - | CR^1^ | - | - | - | - | - | CR^1^ | CR^1^ | CR^1^ | CR^1^ | [Oracle](../../data-transfer/operations/endpoint/source/oracle.md) |
| [{{ PG }}](../../data-transfer/operations/endpoint/source/postgresql.md) | [R^1^](../../data-transfer/tutorials/cdc-mpg.md) | [CR^1^](../../data-transfer/tutorials/rdbms-to-clickhouse.md) | C^1^ | CR | - | CR^1^ | - | [C](../../data-transfer/tutorials/managed-postgresql.md)R | [CR^1^](../../data-transfer/tutorials/mpg-to-ydb.md) | C^1^ | CR | [{{ PG }}](../../data-transfer/operations/endpoint/source/postgresql.md) |
| [{{ ydb-short-name }}](../../data-transfer/operations/endpoint/source/ydb.md) | - | C^1^ | - | C^1^ | - | C^1^ | C^1^ | C^1^ | C^1^ | C^1^ | C^1^ | [{{ ydb-short-name }}](../../data-transfer/operations/endpoint/source/ydb.md) |
| [{{ yds-full-name }}](../../data-transfer/operations/endpoint/source/data-streams.md) | - | CR^1^ | - | C^1^ | - | C^1^ | C^1^ | C^1^ | R^1^ | [R^1^](../../data-transfer/tutorials/yds-to-objstorage.md) | C^1^ | [{{ yds-full-name }}](../../data-transfer/operations/endpoint/source/data-streams.md) |
| [YT](../../data-transfer/operations/endpoint/source/yt.md) | - | R^1^ | - | - | - | - | - | R^1^ | - | - | - | [YT](../../data-transfer/operations/endpoint/source/yt.md) |

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

| Source \ Target | [{{ KF }}](../../data-transfer/operations/endpoint/target/kafka.md) | [{{ CH }}](../../data-transfer/operations/endpoint/target/clickhouse.md) | [{{ GP }}](../../data-transfer/operations/endpoint/target/greenplum.md) | [{{ MG }}](../../data-transfer/operations/endpoint/target/mongodb.md) | [{{ MY }}](../../data-transfer/operations/endpoint/target/mysql.md) | [{{ PG }}](../../data-transfer/operations/endpoint/target/postgresql.md) | [{{ ydb-short-name }}](../../data-transfer/operations/endpoint/target/yandex-database.md) | [{{ objstorage-name }}](../../data-transfer/operations/endpoint/target/object-storage.md) | Source / Target |
|:-------------------------------------------------------------------------------------:|:-------------------------------------------------------------------:|:------------------------------------------------------------------------:|:-----------------------------------------------------------------------:|:---------------------------------------------------------------------:|:-------------------------------------------------------------------:|:------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------:|
| [Airbyte®](#airbyte) | - | C^2^ | - | C^2^ | C^2^ | C^2^ | C^2^ | - | [Airbyte®](#airbyte) |
| [{{ KF }}](../../data-transfer/operations/endpoint/source/kafka.md) | [R^1^](../../data-transfer/tutorials/mkf-to-mkf.md) | R^1^ | - | - | - | - | R^1^ | R^1^ | [{{ KF }}](../../data-transfer/operations/endpoint/source/kafka.md) |
| [{{ CH }}](../../data-transfer/operations/endpoint/source/clickhouse.md) | - | - | - | - | - | - | - | - | [{{ CH }}](../../data-transfer/operations/endpoint/source/clickhouse.md) |
| [{{ GP }}](../../data-transfer/operations/endpoint/source/greenplum.md) | - | [C](../../data-transfer/tutorials/greenplum-to-clickhouse.md) | [C^2^](../../data-transfer/tutorials/managed-greenplum.md) | - | - | [C^2^](../../data-transfer/tutorials/greenplum-to-postgresql.md) | - | - | [{{ GP }}](../../data-transfer/operations/endpoint/source/greenplum.md) |
| [{{ MG }}](../../data-transfer/operations/endpoint/source/mongodb.md) | - | - | - | [CR](../../data-transfer/tutorials/managed-mongodb.md) | - | - | - | C^2^ | [{{ MG }}](../../data-transfer/operations/endpoint/source/mongodb.md) |
| [{{ MY }}](../../data-transfer/operations/endpoint/source/mysql.md) | - | CR^1^ | - | - | [C](../../data-transfer/tutorials/managed-mysql.md)R | - | CR^2^ | C^2^ | [{{ MY }}](../../data-transfer/operations/endpoint/source/mysql.md) |
| [Oracle](../../data-transfer/operations/endpoint/source/oracle.md) | - | CR^2^ | - | - | - | CR^2^ | - | - | [Oracle](../../data-transfer/operations/endpoint/source/oracle.md) |
| [{{ PG }}](../../data-transfer/operations/endpoint/source/postgresql.md) | [R^2^](../../data-transfer/tutorials/cdc-mpg.md) | [CR^1^](../../data-transfer/tutorials/rdbms-to-clickhouse.md) | [C^2^](../../data-transfer/tutorials/managed-greenplum.md) | - | - | [C](../../data-transfer/tutorials/managed-postgresql.md)R | [CR^2^](../../data-transfer/tutorials/mpg-to-ydb.md) | [C^2^](../../data-transfer/tutorials/mpg-to-objstorage.md) | [{{ PG }}](../../data-transfer/operations/endpoint/source/postgresql.md) |
| [{{ ydb-short-name }}](../../data-transfer/operations/endpoint/source/ydb.md) | - | C^1^ | - | - | - | - | - | C^1^ | [{{ ydb-short-name }}](../../data-transfer/operations/endpoint/source/ydb.md) |
| [{{ yds-full-name }}](../../data-transfer/operations/endpoint/source/data-streams.md) | - | [R^1^](../../data-transfer/tutorials/yds-to-clickhouse.md) | - | R^1^ | - | R^1^ | R^1^ | [R^1^](../../data-transfer/tutorials/yds-to-objstorage.md) | [{{ yds-full-name }}](../../data-transfer/operations/endpoint/source/data-streams.md) |

{% endif %}

C: [Copy](../../data-transfer/concepts/transfer-lifecycle.md#copy)
R: [Replicate](../../data-transfer/concepts/transfer-lifecycle.md#replication)
CR: [Copy and replicate](../../data-transfer/concepts/transfer-lifecycle.md#copy-and-replication)

{% if audience != "internal" %}

^1^ This feature is in the [Preview](../../overview/concepts/launch-stages.md) stage.
^2^ This feature is in the [Preview](../../overview/concepts/launch-stages.md) stage and is available upon request. Contact [support]({{ link-console-support }}) or your account manager.

{% else %}

^1^ This feature is in the Preview stage.

{% endif %}

#### Airbyte® endpoints {#airbyte}

You can use [Airbyte®](https://docs.airbyte.com/category/sources) to configure the following source endpoints:

* [AWS CloudTrail](../../data-transfer/operations/endpoint/source/aws-cloudtrail.md)
* [BigQuery](../../data-transfer/operations/endpoint/source/bigquery.md)
* [Microsoft SQL Server](https://docs.airbyte.com/integrations/sources/mssql)
* [S3](../../data-transfer/operations/endpoint/source/s3.md)
