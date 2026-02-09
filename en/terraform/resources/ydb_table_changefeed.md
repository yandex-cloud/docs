---
subcategory: Managed Service for YDB
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/ydb_table_changefeed.md
---

# yandex_ydb_table_changefeed (Resource)

Yandex Database [table changefeed](https://ydb.tech/en/docs/concepts/cdc), or Change Data Capture (CDC) resource, keeps you informed about changes in a given table. When you add, update, or delete a table row, the CDC mechanism generates a change record where it specifies the primary key of the row and writes it to the topic partition corresponding to this key. A [topic](https://ydb.tech/en/docs/concepts/topic) is an entity for storing unstructured messages and delivering them to multiple subscribers. Basically, a topic is a named set of messages.

## Example usage

```terraform
//
// Create a new YDB Table Change feed.
//
resource "yandex_ydb_table_changefeed" "ydb_changefeed" {
  table_id = yandex_ydb_table.test_table_2.id
  name     = "changefeed"
  mode     = "NEW_IMAGE"
  format   = "JSON"

  consumer {
    name = "test_consumer"
  }
}
```

## Arguments & Attributes Reference

- `connection_string` (String). Connection string, conflicts with `table_id`.
- `format` (**Required**)(String). Changefeed format.
- `id` (String). 
- `mode` (**Required**)(String). [Changefeed mode](https://ydb.tech/en/docs/yql/reference/syntax/alter_table#changefeed-options).
- `name` (**Required**)(String). Changefeed name.
- `retention_period` (String). Time of data retention in the topic, [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601) format.
- `table_id` (String). Terraform resource ID of the table.
- `table_path` (String). Table path.
- `virtual_timestamps` (Bool). Use [virtual timestamps](https://ydb.tech/en/docs/concepts/cdc#virtual-timestamps).
- `consumer` [Block]. Changefeed [consumers](https://ydb.tech/en/docs/concepts/topic#consumer) - named entities for reading data from the topic.
  - `important` (Bool). 
  - `name` (**Required**)(String). Consumer name. It is used in the SDK or CLI to [read data](https://ydb.tech/en/docs/best_practices/cdc#read) from the topic.
  - `starting_message_timestamp_ms` (Number). Timestamp in the UNIX timestamp format, from which the consumer will start reading data.
  - `supported_codecs` (List Of String). Supported data encodings.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_ydb_table_changefeed.<resource Name> <resource Id>
terraform import yandex_ydb_table_changefeed.ydb_changefeed ...
```
