---
subcategory: Managed Service for Apache Kafka®
---

# yandex_mdb_kafka_connector (DataSource)

Get information about a connector of the Yandex Managed Kafka cluster. For more information, see [the official documentation](https://yandex.cloud/docs/managed-kafka/concepts).

## Example usage

```terraform
//
// Get information about existing MDB Kafka Connector.
//
data "yandex_mdb_kafka_connector" "foo" {
  cluster_id = "some_cluster_id"
  name       = "test"
}

output "tasks_max" {
  value = data.yandex_mdb_kafka_connector.foo.tasks_max
}
```

## Arguments & Attributes Reference

- `cluster_id` (**Required**)(String). The ID of the Kafka cluster.
- `connector_config_iceberg_sink` [Block]. Settings for Iceberg Sink connector.
  - `control_config` [Block]. Optional control settings.
    - `commit_interval_ms` (Number). Interval between commits in milliseconds. Default: 300000 (5 minutes)
    - `commit_threads` (Number). Number of threads for commit operations. Default: cores * 2
    - `commit_timeout_ms` (Number). Commit operation timeout in milliseconds. Default: 30000 (30 seconds)
    - `group_id_prefix` (String). Consumer group ID prefix for control topic. Default: 'cg-control'
    - `transactional_prefix` (String). Prefix for transactional operations. Default: ''
  - `control_topic` (String). Control topic name for Iceberg connector.
  - `dynamic_tables` [Block]. Dynamic table routing configuration. Cannot be changed after creation.
    - `route_field` (**Required**)(String). Field in the message to define the target table.
  - `metastore_connection` [Block]. Settings for connection to Hive Metastore.
    - `catalog_uri` (**Required**)(String). Thrift URI of Hive Metastore. Format: 'thrift://host:9083'
    - `warehouse` (**Required**)(String). Warehouse root directory in S3. Format: 's3a://bucket-name/path/to/warehouse'
  - `s3_connection` [Block]. Settings for connection to s3-compatible storage.
    - `external_s3` [Block]. Connection params for external s3-compatible storage.
      - `access_key_id` (String). ID of aws-compatible static key.
      - `endpoint` (**Required**)(String). URL of s3-compatible storage.
      - `region` (String). Region of s3-compatible storage.
      - `secret_access_key` (String). Secret key of aws-compatible static key.
  - `static_tables` [Block]. Static table routing configuration. Cannot be changed after creation.
    - `tables` (**Required**)(String). List of tables, separated by ','.
  - `tables_config` [Block]. Optional table settings.
    - `default_commit_branch` (String). Default Git-like branch name for Iceberg commits. Default: 'main'
    - `default_id_columns` (String). List of columns used as identifiers for upsert operations, separated by ','.
    - `default_partition_by` (String). Comma-separated list of columns or transform expressions for table partitioning.
    - `evolve_schema_enabled` (Bool). Enable automatic schema evolution. Default: false
    - `schema_case_insensitive` (Bool). Enable case-insensitive field name matching. Default: false
    - `schema_force_optional` (Bool). Force all columns to be nullable. Default: false
  - `topics` (String). The pattern for topic names to be written to Iceberg tables.
  - `topics_regex` (String). Regex pattern for topic names to be written to Iceberg tables.
- `connector_config_mirrormaker` [Block]. Settings for MirrorMaker2 connector.
  - `replication_factor` (**Required**)(Number). Replication factor for topics created in target cluster.
  - `source_cluster` [Block]. Settings for source cluster.
    - `alias` (String). Name of the cluster. Used also as a topic prefix.
    - `external_cluster` [Block]. Connection settings for external cluster.
      - `bootstrap_servers` (**Required**)(String). List of bootstrap servers to connect to cluster.
      - `sasl_mechanism` (String). Type of SASL authentification mechanism to use.
      - `sasl_password` (String). Password to use in SASL authentification mechanism
      - `sasl_username` (String). Username to use in SASL authentification mechanism.
      - `security_protocol` (String). Security protocol to use.
    - `this_cluster` [Block]. Using this section in the cluster definition (source or target) means it's this cluster.
  - `target_cluster` [Block]. Settings for target cluster.
    - `alias` (String). Name of the cluster. Used also as a topic prefix.
    - `external_cluster` [Block]. Connection settings for external cluster.
      - `bootstrap_servers` (**Required**)(String). List of bootstrap servers to connect to cluster.
      - `sasl_mechanism` (String). Type of SASL authentification mechanism to use.
      - `sasl_password` (String). Password to use in SASL authentification mechanism
      - `sasl_username` (String). Username to use in SASL authentification mechanism.
      - `security_protocol` (String). Security protocol to use.
    - `this_cluster` [Block]. Using this section in the cluster definition (source or target) means it's this cluster.
  - `topics` (**Required**)(String). The pattern for topic names to be replicated.
- `connector_config_s3_sink` [Block]. Settings for S3 Sink connector.
  - `file_compression_type` (**Required**)(String). Compression type for messages. Cannot be changed.
  - `file_max_records` (Number). Max records per file.
  - `s3_connection` [Block]. Settings for connection to s3-compatible storage.
    - `bucket_name` (**Required**)(String). Name of the bucket in s3-compatible storage.
    - `external_s3` [Block]. Connection params for external s3-compatible storage.
      - `access_key_id` (String). ID of aws-compatible static key.
      - `endpoint` (**Required**)(String). URL of s3-compatible storage.
      - `region` (String). Region of s3-compatible storage. [Available region list](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/regions/Regions.html).
      - `secret_access_key` (String). Secret key of aws-compatible static key.
  - `topics` (**Required**)(String). The pattern for topic names to be copied to s3 bucket.
- `id` (String). 
- `name` (**Required**)(String). The resource name.
- `properties` (Map Of String). Additional properties for connector.
- `tasks_max` (Number). The number of the connector's parallel working tasks. Default is the number of brokers.


