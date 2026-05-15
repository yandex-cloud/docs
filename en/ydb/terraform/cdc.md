---
title: Creating a change data feed for a {{ ydb-full-name }} table in {{ TF }}
description: Follow this guide to create or update a change data feed for a {{ ydb-short-name }} table.
---

# Creating a change data feed for a table

[Change data capture (CDC)]({{ ydb.docs }}/concepts/cdc) is a process of tracking changes in a particular table and delivering them to a consumer. When you add, update, or delete a table row, CDC generates a change record with the primary key of the row and writes it to the topic partition matching this key. A [topic]({{ ydb.docs }}/concepts/topic) is an entity for storing unstructured messages and delivering them to multiple subscribers. Basically, a topic is a named set of messages.

## Description of the yandex_ydb_table_changefeed resource {#table_changefeed_description}

You can create a change data feed (CDF) for a table using the `yandex_ydb_table_changefeed` resource:

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

We used the following fields to create a table CDF:
* `table_id`: ID of the table to create a CDF for.
* `name`: CDF name.
* `mode`: CDF mode. For all available CDF modes, see [this guide]({{ ydb.docs }}/yql/reference/syntax/alter_table#changefeed-options).
* `format`: CDF format. Only JSON format is available.

Full description of all the `yandex_ydb_table_changefeed` resource fields:
| **Field name** | **Type** | **Description** |
| --- | --- | --- |
|table_path|`string`<br>`required`|Table path.|
|connection_string|`string`<br>`required`|Connection string, conflicts with `table_id`.|
|database_id|`string`<br>`required`|Database ID, conflicts with `table_path` and `connection_string`.|
|table_id|`string`<br>`required`|Terraform table ID.|
|name|`string`<br>`required`|CDF name.|
|mode|`string`<br>`required`|[CDF mode]({{ ydb.docs }}/yql/reference/syntax/alter_table#changefeed-options).|
|format|`string`<br>`required`|CDF format.|
|virtual_timestamps|`bool`<br>`optional`|Using [virtual timestamps]({{ ydb.docs }}/concepts/cdc#virtual-timestamps).|
|retention_period|`string`<br>`optional`|Data retention period in a topic, in [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601) format.|
|consumer|`array[consumer]`<br>`optional`|Consumers for a CDF.|

When initializing the `yandex_ydb_table_changefeed` resource, you can only specify one connection field: `connection_string`, `table_path`, or `table_id`. If you specify multiple connection fields, they will come into conflict, e.g., the `table_id` field with a relative link in `<resource>.<ID>.<parameter>` format: `yandex_ydb_table.test_table_2.id`.

The CDF resource contains the `consumer` section. A [consumer]({{ ydb.docs }}/concepts/topic#consumer) is a named entity for reading data from the topic. Each consumer has several setting fields. The main field is `name`, i.e., the consumer's name. When initializing the `yandex_ydb_table_changefeed` resource, you can specify multiple consumers, or none; however, in this case, you will not be able to read data from the CDF.

Full list of the `consumer` section fields:
| **Field name** | **Type** | **Description** |
| --- | --- | --- |
| name | `string`<br>`required` | Consumer name. |
| supported_codecs | `array[string]`<br>`optional` | Supported data encodings. |
| starting_message_timestamp_ms | `integer`<br>`optional` | UNIX timestamp for the consumer to start reading data from. |

The consumer name is used in the SDK or CLI to [read data]({{ ydb.docs }}/best_practices/cdc#read) from the topic.
