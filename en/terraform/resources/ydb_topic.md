---
subcategory: Managed Service for YDB
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/ydb_topic.md
---

# yandex_ydb_topic (Resource)

Manage a YDB Topic. For more information, see [the official documentation](https://yandex.cloud/docs/ydb/concepts/#ydb).

## Example usage

```terraform
//
// Create a new YDB Topic.
//
resource "yandex_ydb_topic" "my_topic" {
  database_endpoint = yandex_ydb_database_serverless.database_name.ydb_full_endpoint
  name              = "topic-test"

  supported_codecs    = ["raw", "gzip"]
  partitions_count    = 1
  retention_period_ms = 2000000
  consumer {
    name                          = "consumer-name"
    supported_codecs              = ["raw", "gzip"]
    starting_message_timestamp_ms = 0
  }
}

resource "yandex_ydb_database_serverless" "database_name" {
  name        = "database-name"
  location_id = "ru-central1"
}
```

## Arguments & Attributes Reference

- `database_endpoint` (**Required**)(String). YDB database endpoint.
- `description` (String). Topic description.
- `id` (String). 
- `max_partitions_count` (Number). Number of max active partitions. Default value `1`.
- `metering_mode` (String). Resource metering mode (`reserved_capacity` - based on the allocated resources or `request_units` - based on actual usage). This option applies to topics in serverless databases.
- `name` (**Required**)(String). Topic name.
- `partition_write_speed_kbps` (Number). Maximum allowed write speed per partition. If a write speed for a given partition exceeds this value, the write speed will be capped. Default value: `1024 (1MB)`.
- `partitions_count` (Number). Number of min partitions. Default value `1`.
- `retention_period_hours` (Number). Data retention time. Default value `86400000`.
- `retention_storage_mb` (Number). 
- `supported_codecs` (Set Of String). Supported data encodings. Can be one of `gzip`, `raw` or `zstd`.
- `auto_partitioning_settings` [Block]. 
  - `auto_partitioning_strategy` (String). The auto partitioning strategy to use
  - `auto_partitioning_write_speed_strategy` [Block]. 
    - `down_utilization_percent` (Number). The down utilization percentage threshold
    - `stabilization_window` (Number). The stabilization window in seconds
    - `up_utilization_percent` (Number). The up utilization percentage threshold
- `consumer` [Block]. Topic Readers.
  - `important` (Bool). Defines an important consumer. No data will be deleted from the topic until all the important consumers read them. Default value `false`.
  - `name` (**Required**)(String). Reader's name.
  - `starting_message_timestamp_ms` (Number). Timestamp in UNIX timestamp format from which the reader will start reading data. Default value `0`.
  - `supported_codecs` (Set Of String). Supported data encodings. Can be one of `gzip`, `raw` or `zstd`.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_ydb_topic.<resource Name> <resource Id>
terraform import yandex_ydb_topic.my_topic ...
```
