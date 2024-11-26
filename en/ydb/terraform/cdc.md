---
title: Creating a changefeed for a {{ ydb-full-name }} table in {{ TF }}
description: Follow this guide to create a changefeed for a {{ ydb-short-name }} table or change its parameters.
---

# Creating a changefeed for a table

[Table changefeed]({{ ydb.docs }}/concepts/cdc), or Change Data Capture (CDC), keeps you informed about changes in a particular table. When you add, update, or delete a table row, the CDC mechanism generates a change record where it specifies the primary key of the row and writes it to the topic partition corresponding to this key. A [topic]({{ ydb.docs }}/concepts/topic) is an entity for storing unstructured messages and delivering them to multiple subscribers. Basically, a topic is a named set of messages.

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
* `table_id`: ID of the table you create a changefeed for.
* `name`: Changefeed name.
* `mode`: Changefeed operating mode. The available changefeed operating modes are presented in the [documentation]({{ ydb.docs }}/yql/reference/syntax/alter_table#changefeed-options).
* `format`: Changefeed format. Only JSON format is available.

Full description of all `yandex_ydb_table_changefeed` resource fields:
| **Field name** | **Type** | **Description** |
| --- | --- | --- |
|table_path|`string`<br>`required`|Table path|
|connection_string|`string`<br>`required`|Connection string, conflicts with `table_id`|
|database_id|`string`<br>`required`|Database ID, conflicts with `table_path` and `connection_string`|
|table_id|`string`<br>`required`|Terraform table ID|
|name|`string`<br>`required`|Changefeed name|
|mode|`string`<br>`required`|[Changefeed operating mode]({{ ydb.docs }}/yql/reference/syntax/alter_table#changefeed-options)|
|format|`string`<br>`required`|Changefeed format|
|virtual_timestamps|`bool`<br>`optional`|Using [virtual timestamps]({{ ydb.docs }}/concepts/cdc#virtual-timestamps)|
|retention_period|`string`<br>`optional`|Data storage time in a topic in [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601) format|
|consumer|`array[consumer]`<br>`optional`|Consumers (readers) for the changefeed|

When initializing the `yandex_ydb_table_changefeed` resource, you can specify only one connection field: `connection_string`, `table_path`, or `table_id`. If you specify multiple connection fields, they will come into conflict. For example, the `table_id` field with a relative link in `<recourse>.<ID>.<parameter>` format: `yandex_ydb_table.test_table_2.id`.

The `consumer` section resides inside the changefeed resource. A [consumer]({{ ydb.docs }}/concepts/topic#consumer) is a named entity for reading data from the topic. A consumer has several fields of settings. The main field is `name`, which is the consumer's name. When initializing the `yandex_ydb_table_changefeed` resource, you can specify multiple readers, or you can create none, but then you cannot read data from the changefeed.

Full list of the `consumer` section fields:
| **Field name** | **Type** | **Description** |
| --- | --- | --- |
| name | `string`<br>`required` | Reader name |
| supported_codecs | `array[string]`<br>`optional` | Supported data encodings |
| starting_message_timestamp_ms | `integer`<br>`optional` | The UNIX timestamp the reader will start reading data at. |

The consumer name is used in the SDK or CLI to [read data]({{ ydb.docs }}/best_practices/cdc#read) from the topic.