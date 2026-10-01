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
- `connector_config_iceberg_sink` (*Read-Only*) (List Of Object). Settings for Iceberg Sink connector.
  - `control_config` . 
    - `commit_interval_ms` . 
    - `commit_threads` . 
    - `commit_timeout_ms` . 
    - `group_id_prefix` . 
    - `transactional_prefix` . 
  - `control_topic` . 
  - `dynamic_tables` . 
    - `route_field` . 
  - `metastore_connection` . 
    - `catalog_uri` . 
    - `warehouse` . 
  - `s3_connection` . 
    - `external_s3` . 
      - `access_key_id` . 
      - `endpoint` . 
      - `region` . 
      - `secret_access_key` . 
  - `static_tables` . 
    - `tables` . 
  - `tables_config` . 
    - `default_commit_branch` . 
    - `default_id_columns` . 
    - `default_partition_by` . 
    - `evolve_schema_enabled` . 
    - `schema_case_insensitive` . 
    - `schema_force_optional` . 
  - `topics` . 
  - `topics_regex` . 
- `connector_config_mirrormaker` (*Read-Only*) (List Of Object). Settings for MirrorMaker2 connector.
  - `replication_factor` . 
  - `source_cluster` . 
    - `alias` . 
    - `external_cluster` . 
      - `bootstrap_servers` . 
      - `sasl_mechanism` . 
      - `sasl_password` . 
      - `sasl_username` . 
      - `security_protocol` . 
    - `this_cluster` . 
  - `target_cluster` . 
    - `alias` . 
    - `external_cluster` . 
      - `bootstrap_servers` . 
      - `sasl_mechanism` . 
      - `sasl_password` . 
      - `sasl_username` . 
      - `security_protocol` . 
    - `this_cluster` . 
  - `topics` . 
- `connector_config_s3_sink` (*Read-Only*) (List Of Object). Settings for S3 Sink connector.
  - `file_compression_type` . 
  - `file_max_records` . 
  - `s3_connection` . 
    - `bucket_name` . 
    - `external_s3` . 
      - `access_key_id` . 
      - `endpoint` . 
      - `region` . 
      - `secret_access_key` . 
  - `topics` . 
- `id` (String). 
- `name` (**Required**)(String). The resource name.
- `properties` (*Read-Only*) (Map Of String). Additional properties for connector.
- `tasks_max` (*Read-Only*) (Number). The number of the connector's parallel working tasks. Default is the number of brokers.


