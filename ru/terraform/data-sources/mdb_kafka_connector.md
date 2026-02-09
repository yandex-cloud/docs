---
subcategory: Managed Service for Apache Kafka®
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/mdb_kafka_connector.md
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


