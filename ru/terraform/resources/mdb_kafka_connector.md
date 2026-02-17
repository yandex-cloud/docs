---
subcategory: Managed Service for Apache Kafka®
---

# yandex_mdb_kafka_connector (Resource)

Manages a connector of a Kafka cluster within the Yandex Cloud. For more information, see [the official documentation](https://yandex.cloud/docs/managed-kafka/concepts).

## Example usage

```terraform
//
// Create a new MDB Kafka Connector.
//
resource "yandex_mdb_kafka_connector" "my_conn" {
  cluster_id = yandex_mdb_kafka_cluster.my_cluster.id
  name       = "replication"
  tasks_max  = 3
  properties = {
    refresh.topics.enabled = "true"
  }
  connector_config_mirrormaker {
    topics             = "data.*"
    replication_factor = 1
    source_cluster {
      alias = "source"
      external_cluster {
        bootstrap_servers = "somebroker1:9091,somebroker2:9091"
        sasl_username     = "someuser"
        sasl_password     = "somepassword"
        sasl_mechanism    = "SCRAM-SHA-512"
        security_protocol = "SASL_SSL"
      }
    }
    target_cluster {
      alias = "target"
      this_cluster {}
    }
  }
}

resource "yandex_mdb_kafka_connector" "connector" {
  cluster_id = yandex_mdb_kafka_cluster.my_cluster.id
  name       = "s3-sink"
  tasks_max  = 3
  properties = {
    "key.converter"                  = "org.apache.kafka.connect.storage.StringConverter"
    "value.converter"                = "org.apache.kafka.connect.json.JsonConverter"
    "value.converter.schemas.enable" = "false"
    "format.output.type"             = "jsonl"
    "file.name.template"             = "dir1/dir2/not_var{{topic}}-not_var{{partition:padding=true}}-not_var{{start_offset:padding=true}}.gz"
    "timestamp.timezone"             = "Europe/Moscow"
  }
  connector_config_s3_sink {
    topics                = "data.*"
    file_compression_type = "gzip"
    file_max_records      = 100
    s3_connection {
      bucket_name = "somebucket"
      external_s3 {
        endpoint          = "storage.yandexcloud.net"
        access_key_id     = "some_access_key_id"
        secret_access_key = "some_secret_access_key"
      }
    }
  }
}

resource "yandex_mdb_kafka_cluster" "my_cluster" {
  name       = "foo"
  network_id = "c64vs98keiqc7f24pvkd"

  config {
    version = "2.8"
    zones   = ["ru-central1-a"]
    kafka {
      resources {
        resource_preset_id = "s2.micro"
        disk_type_id       = "network-hdd"
        disk_size          = 16
      }
    }
  }
}
```

## Arguments & Attributes Reference

- `cluster_id` (**Required**)(String). The ID of the Kafka cluster.
- `id` (String). 
- `name` (**Required**)(String). The resource name.
- `properties` (Map Of String). Additional properties for connector.
- `tasks_max` (Number). The number of the connector's parallel working tasks. Default is the number of brokers.
- `connector_config_mirrormaker` [Block]. Settings for MirrorMaker2 connector.
  - `replication_factor` (**Required**)(Number). Replication factor for topics created in target cluster.
  - `topics` (**Required**)(String). The pattern for topic names to be replicated.
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
- `connector_config_s3_sink` [Block]. Settings for S3 Sink connector.
  - `file_compression_type` (**Required**)(String). Compression type for messages. Cannot be changed.
  - `file_max_records` (Number). Max records per file.
  - `topics` (**Required**)(String). The pattern for topic names to be copied to s3 bucket.
  - `s3_connection` [Block]. Settings for connection to s3-compatible storage.
    - `bucket_name` (**Required**)(String). Name of the bucket in s3-compatible storage.
    - `external_s3` [Block]. Connection params for external s3-compatible storage.
      - `access_key_id` (String). ID of aws-compatible static key.
      - `endpoint` (**Required**)(String). URL of s3-compatible storage.
      - `region` (String). Region of s3-compatible storage. [Available region list](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/regions/Regions.html).
      - `secret_access_key` (String). Secret key of aws-compatible static key.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_mdb_kafka_connector.<resource Name> <resource Id>
terraform import yandex_mdb_kafka_connector.my_conn ...
```
