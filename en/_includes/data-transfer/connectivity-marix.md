Possible source and target combinations:



| Source \ Target | [{{ KF }}](../../data-transfer/operations/endpoint/target/kafka.md) | [{{ CH }}](../../data-transfer/operations/endpoint/target/clickhouse.md) | [{{ GP }}](../../data-transfer/operations/endpoint/target/greenplum.md) | [{{ MG }}](../../data-transfer/operations/endpoint/target/mongodb.md) | [{{ MY }}](../../data-transfer/operations/endpoint/target/mysql.md) | [{{ PG }}](../../data-transfer/operations/endpoint/target/postgresql.md) | [{{ ydb-short-name }}](../../data-transfer/operations/endpoint/target/yandex-database.md) | [{{ objstorage-name }}](../../data-transfer/operations/endpoint/target/object-storage.md) | Source / Target |
|:-------------------------------------------------------------------------------------:|:-------------------------------------------------------------------:|:------------------------------------------------------------------------:|:-----------------------------------------------------------------------:|:---------------------------------------------------------------------:|:-------------------------------------------------------------------:|:------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------:|
| [Airbyte®](#airbyte) | - | C^1^ | - | C^1^ | C^1^ | C^1^ | C^1^ | - | [Airbyte®](#airbyte) |
| [{{ KF }}](../../data-transfer/operations/endpoint/source/kafka.md) | R^1^ | [R^1^](../../data-transfer/tutorials/mkf-to-mch.md) | R^1^ | - | - | - | [R^1^](../../data-transfer/tutorials/mkf-to-ydb.md) | R^1^ | [{{ KF }}](../../data-transfer/operations/endpoint/source/kafka.md) |
| [{{ CH }}](../../data-transfer/operations/endpoint/source/clickhouse.md) | - | [C](../../data-transfer/tutorials/managed-clickhouse.md) | - | - | - | - | - | - | [{{ CH }}](../../data-transfer/operations/endpoint/source/clickhouse.md) |
| [{{ GP }}](../../data-transfer/operations/endpoint/source/greenplum.md) | - | [C](../../data-transfer/tutorials/greenplum-to-clickhouse.md) | [C^1^](../../data-transfer/tutorials/managed-greenplum.md) | - | - | [C^1^](../../data-transfer/tutorials/greenplum-to-postgresql.md) | - | - | [{{ GP }}](../../data-transfer/operations/endpoint/source/greenplum.md) |
| [{{ MG }}](../../data-transfer/operations/endpoint/source/mongodb.md) | - | - | - | [CR](../../data-transfer/tutorials/managed-mongodb.md) | - | - | - | C^1^ | [{{ MG }}](../../data-transfer/operations/endpoint/source/mongodb.md) |
| [{{ MY }}](../../data-transfer/operations/endpoint/source/mysql.md) | [CR](../../data-transfer/tutorials/cdc-mmy.md) | CR | - | - | [C](../../data-transfer/tutorials/managed-mysql.md)R | - | [CR^1^](../../data-transfer/tutorials/managed-mysql-to-ydb.md) | [C^1^](../../data-transfer/tutorials/mmy-objs-migration.md) | [{{ MY }}](../../data-transfer/operations/endpoint/source/mysql.md) |
| [Oracle](../../data-transfer/operations/endpoint/source/oracle.md) | - | CR^1^ | - | - | - | CR^1^ | - | - | [Oracle](../../data-transfer/operations/endpoint/source/oracle.md) |
| [{{ PG }}](../../data-transfer/operations/endpoint/source/postgresql.md) | [CR](../../data-transfer/tutorials/cdc-mpg.md) | [CR](../../data-transfer/tutorials/rdbms-to-clickhouse.md) | [C^1^](../../data-transfer/tutorials/managed-greenplum.md) | - | - | [C](../../data-transfer/tutorials/managed-postgresql.md)R | CR^1^ | C^1^ | [{{ PG }}](../../data-transfer/operations/endpoint/source/postgresql.md) |
| [{{ ydb-short-name }}](../../data-transfer/operations/endpoint/source/ydb.md) | - | C^1^ | - | - | - | - | - | C^1^ | [{{ ydb-short-name }}](../../data-transfer/operations/endpoint/source/ydb.md) |
| [{{ yds-full-name }}](../../data-transfer/operations/endpoint/source/data-streams.md) | - | [R^1^](../../data-transfer/tutorials/yds-to-clickhouse.md) | R^1^ | R^1^ | - | R^1^ | R^1^ | [R^1^](../../data-transfer/tutorials/yds-to-objstorage.md) | [{{ yds-full-name }}](../../data-transfer/operations/endpoint/source/data-streams.md) |




C: [Copy](../../data-transfer/concepts/transfer-lifecycle.md#copy)
R: [Replicate](../../data-transfer/concepts/transfer-lifecycle.md#replication)
CR: [Copy and replicate](../../data-transfer/concepts/transfer-lifecycle.md#copy-and-replication)


^1^ This feature is in the [Preview](../../overview/concepts/launch-stages.md) stage.
^2^ This feature is in the [Preview](../../overview/concepts/launch-stages.md) stage and is available upon request. Contact [support]({{ link-console-support }}) or your account manager.


#### Airbyte® endpoints {#airbyte}

You can use [Airbyte®](https://docs.airbyte.com/category/sources) to configure the following source endpoints:

* [AWS CloudTrail](../../data-transfer/operations/endpoint/source/aws-cloudtrail.md)
* [BigQuery](../../data-transfer/operations/endpoint/source/bigquery.md)
* [Microsoft SQL Server](https://docs.airbyte.com/integrations/sources/mssql)
* [S3](../../data-transfer/operations/endpoint/source/s3.md)
