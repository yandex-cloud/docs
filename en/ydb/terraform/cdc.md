---
title: Creating a changefeed for a {{ ydb-full-name }} table using {{ TF }}
description: Follow this guide to create a changefeed for a {{ ydb-full-name }} table or change its parameters.
---

# Creating a changefeed for a table

[Table changefeed](https://ydb.tech/docs/ru/concepts/cdc), or Change Data Capture (CDC), keeps you informed about changes in a given table. When you add, update, or delete a table row, the CDC mechanism generates a change record where it specifies the primary key of the row and writes it to the topic partition corresponding to this key. A [topic](https://ydb.tech/docs/ru/concepts/topic) is an entity for storing unstructured messages and delivering them to multiple subscribers. Basically, a topic is a named set of messages.

## Description of the `yandex_ydb_table_changefeed` resource {#table_changefeed_description}

You can create a changefeed for a table using the `yandex_ydb_table_changefeed` resource:

```tf
resource "yandex_ydb_table_changefeed" "ydb_changefeed" {
  table_id = yandex_ydb_table.test_table_2.id
  name = "changefeed"
  mode = "NEW_IMAGE"
  format = "JSON"

  consumer {
    name = "test_consumer"
  }
}
```

We used the following fields to create a table changefeed:
* `table_id`: ID of the table for which we create the changefeed.
* `name`: Changefeed name.
* `mode`: Changefeed operating mode. The available changefeed operating modes are presented in the [documentation](https://ydb.tech/docs/en/yql/reference/syntax/alter_table#changefeed-options).
* `format`: Changefeed format. Only JSON format is available.

Full descriptioin of all the `yandex_ydb_table_changefeed` resource fields:
| **Field name** | **Type** | **Description** |
| --- | --- | --- |
|table_path|`string`<br>`required`|Path to table|
|connection_string|`string`<br>`required`|Connection string, conflicts with `table_id`|
|database_id|`string`<br>`required`|Database ID, conflicts with `table_path` and `connection_string`|
|table_id|`string`<br>`required`|Terraform ID of the table|
|name|`string`<br>`required`|Changefeed name|
|mode|`string`<br>`required`|[Changefeed mode](https://ydb.tech/docs/en/yql/reference/syntax/alter_table#changefeed-options)|
|format|`string`<br>`required`|Changefeed format|
|virtual_timestamps|`bool`<br>`optional`|Using [virtual timestamps](https://ydb.tech/docs/en/concepts/cdc#virtual-timestamps)|
|retention_period|`string`<br>`optional`|Time period of data retention in the topic in [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601) format|
|consumer|`array[consumer]`<br>`optional`|Changefeed consumers|

When initializing the `yandex_ydb_table_changefeed` resource, you can specify only one connection field: `connection_string`, `table_path`, or `table_id`. If you specify multiple connection fields, they will come into conflict. For example, the `table_id` field with a relative link in `<resource>.<ID>.<parameter>`: `yandex_ydb_table.test_table_2.id` format.

The `consumer` section resides inside the changefeed resource. A [consumer](https://ydb.tech/docs/en/concepts/topic#consumer) is a named entity for reading data from the topic. A consumer has several fields of settings. The main field is `name`, which is the consumer's name. When initializing the `yandex_ydb_table_changefeed` resource, you can set up multiple consumers or none, in which case you will not be able to read data from the changefeed.

Full list of the `consumer` section fields:
| **Field name** | **Type** | **Description** |
| --- | --- | --- |
| name | `string`<br>`required` | Consumer name |
| supported_codecs | `array[string]`<br>`optional` | Supported data encodings |
| starting_message_timestamp_ms | `integer`<br>`optional` | Timestamp in UNIX timestamp format, from which the consumer will start reading data |

The consumer name is used in the SDK or CLI to [read data](https://ydb.tech/docs/en/best_practices/cdc#read) from the topic.