---
subcategory: Managed Service for Trino
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/trino_catalog.md
---

# yandex_trino_catalog (DataSource)

Catalog for Managed Trino cluster.


## Arguments & Attributes Reference

- `clickhouse` [Block]. Configuration for Clickhouse connector.
  - `additional_properties` (Map Of String). Additional properties.
  - `connection_manager` [Block]. Configuration for connection manager connection.
    - `connection_id` (**Required**)(String). Connection ID.
    - `connection_properties` (Map Of String). Additional connection properties.
    - `database` (**Required**)(String). Database.
  - `on_premise` [Block]. Configuration for on-premise connection.
    - `connection_url` (**Required**)(String). Connection to the clickhouse.
    - `password` (**Required**)(String). Password of the clickhouse user.
    - `user_name` (**Required**)(String). Name of the clickhouse user.
- `cluster_id` (**Required**)(String). ID of the Trino cluster. Provided by the client when the Catalog is created.
- `delta_lake` [Block]. Configuration for DeltaLake connector.
  - `additional_properties` (Map Of String). Additional properties.
  - `file_system` [Block]. File system configuration.
    - `external_s3` [Block]. Describes External S3 compatible file system.
      - `aws_access_key` (**Required**)(String). AWS access key ID for S3 authentication.
      - `aws_endpoint` (**Required**)(String). AWS S3 compatible endpoint URL.
      - `aws_region` (**Required**)(String). AWS region for S3 storage.
      - `aws_secret_key` (**Required**)(String). AWS secret access key for S3 authentication.
    - `s3` [Block]. Describes YandexCloud native S3 file system.
  - `metastore` [Block]. Metastore configuration.
    - `uri` (**Required**)(String). The resource description.
- `description` (String). The resource description.
- `greenplum` [Block]. Configuration for Greenplum/Cloudberry connector.
  - `additional_properties` (Map Of String). Additional properties.
  - `connection_manager` [Block]. Configuration for connection manager connection.
    - `connection_id` (**Required**)(String). Connection ID.
    - `connection_properties` (Map Of String). Additional connection properties.
    - `database` (**Required**)(String). Database.
  - `on_premise` [Block]. Configuration for on-premise connection.
    - `connection_url` (**Required**)(String). Connection to the clickhouse.
    - `password` (**Required**)(String). Password of the clickhouse user.
    - `user_name` (**Required**)(String). Name of the clickhouse user.
- `hive` [Block]. Configuration for Hive connector.
  - `additional_properties` (Map Of String). Additional properties.
  - `file_system` [Block]. File system configuration.
    - `external_s3` [Block]. Describes External S3 compatible file system.
      - `aws_access_key` (**Required**)(String). AWS access key ID for S3 authentication.
      - `aws_endpoint` (**Required**)(String). AWS S3 compatible endpoint URL.
      - `aws_region` (**Required**)(String). AWS region for S3 storage.
      - `aws_secret_key` (**Required**)(String). AWS secret access key for S3 authentication.
    - `s3` [Block]. Describes YandexCloud native S3 file system.
  - `metastore` [Block]. Metastore configuration.
    - `uri` (**Required**)(String). The resource description.
- `hudi` [Block]. Configuration for Hudi connector.
  - `additional_properties` (Map Of String). Additional properties.
  - `file_system` [Block]. File system configuration.
    - `external_s3` [Block]. Describes External S3 compatible file system.
      - `aws_access_key` (**Required**)(String). AWS access key ID for S3 authentication.
      - `aws_endpoint` (**Required**)(String). AWS S3 compatible endpoint URL.
      - `aws_region` (**Required**)(String). AWS region for S3 storage.
      - `aws_secret_key` (**Required**)(String). AWS secret access key for S3 authentication.
    - `s3` [Block]. Describes YandexCloud native S3 file system.
  - `metastore` [Block]. Metastore configuration.
    - `uri` (**Required**)(String). The resource description.
- `iceberg` [Block]. Configuration for Iceberg connector.
  - `additional_properties` (Map Of String). Additional properties.
  - `file_system` [Block]. File system configuration.
    - `external_s3` [Block]. Describes External S3 compatible file system.
      - `aws_access_key` (**Required**)(String). AWS access key ID for S3 authentication.
      - `aws_endpoint` (**Required**)(String). AWS S3 compatible endpoint URL.
      - `aws_region` (**Required**)(String). AWS region for S3 storage.
      - `aws_secret_key` (**Required**)(String). AWS secret access key for S3 authentication.
    - `s3` [Block]. Describes YandexCloud native S3 file system.
  - `metastore` [Block]. Metastore configuration.
    - `uri` (**Required**)(String). The resource description.
- `id` (*Read-Only*) (String). The resource identifier.
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `mysql` [Block]. Configuration for MySQL connector.
  - `additional_properties` (Map Of String). Additional properties.
  - `connection_manager` [Block]. Configuration for MySQL connection manager connection.
    - `connection_id` (**Required**)(String). Connection ID.
    - `connection_properties` (Map Of String). Additional connection properties.
  - `on_premise` [Block]. Configuration for on-premise connection.
    - `connection_url` (**Required**)(String). Connection to the clickhouse.
    - `password` (**Required**)(String). Password of the clickhouse user.
    - `user_name` (**Required**)(String). Name of the clickhouse user.
- `name` (**Required**)(String). The resource name.
- `oracle` [Block]. Configuration for Oracle connector.
  - `additional_properties` (Map Of String). Additional properties.
  - `on_premise` [Block]. Configuration for on-premise connection.
    - `connection_url` (**Required**)(String). Connection to the clickhouse.
    - `password` (**Required**)(String). Password of the clickhouse user.
    - `user_name` (**Required**)(String). Name of the clickhouse user.
- `postgresql` [Block]. Configuration for Postgresql connector.
  - `additional_properties` (Map Of String). Additional properties.
  - `connection_manager` [Block]. Configuration for connection manager connection.
    - `connection_id` (**Required**)(String). Connection ID.
    - `connection_properties` (Map Of String). Additional connection properties.
    - `database` (**Required**)(String). Database.
  - `on_premise` [Block]. Configuration for on-premise connection.
    - `connection_url` (**Required**)(String). Connection to the clickhouse.
    - `password` (**Required**)(String). Password of the clickhouse user.
    - `user_name` (**Required**)(String). Name of the clickhouse user.
- `sqlserver` [Block]. Configuration for SQLServer connector.
  - `additional_properties` (Map Of String). Additional properties.
  - `on_premise` [Block]. Configuration for on-premise connection.
    - `connection_url` (**Required**)(String). Connection to the clickhouse.
    - `password` (**Required**)(String). Password of the clickhouse user.
    - `user_name` (**Required**)(String). Name of the clickhouse user.
- `tpcds` [Block]. Configuration for TPCDS connector.
  - `additional_properties` (Map Of String). Additional properties.
- `tpch` [Block]. Configuration for TPCH connector.
  - `additional_properties` (Map Of String). Additional properties.


