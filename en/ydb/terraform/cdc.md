# Creating a changefeed for a table {#cdc}
[Table changefeed](https://ydb.tech/ru/docs/concepts/cdc), or Change Data Capture (CDC), keeps you informed about changes in a given table. When you add, update, or delete a table row, the CDC mechanism generates a change record where it specifies the primary key of the row and writes it to the topic partition corresponding to this key. A [topic](https://ydb.tech/ru/docs/concepts/topic) is an entity for storing unstructured messages and delivering them to multiple subscribers. Basically, a topic is a named set of messages.

To create a changefeed for a table, use the `"yandex_ydb_table_changefeed"` resource:

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

We used the following parameters to create a table changefeed:
* `table_id`: ID of the table for which we create the changefeed.
* `name`: Changefeed name.
* `mode`: Changefeed operating mode. The available changefeed operating modes are presented in the [documentation](https://ydb.tech/ru/docs/yql/reference/syntax/alter_table#changefeed-options).
* `format`: Changefeed format. Only JSON format is available.

This table describes all the `"yandex_ydb_table_changefeed"` resource parameters:
| **Field name** | **Type** | **Description** |
| --- | --- | --- |
|table_path|`string`<br>`required`|Table path|
|connection_string|`string`<br>`required`|Connection string, conflicts with `table_id`|
|database_id|`string`<br>`required`|Database ID, conflicts with `table_path` and `connection_string`|
|table_id|`string`<br>`required`|Terraform ID of the table|
|name|`string`<br>`required`|Changefeed name|
|mode|`string`<br>`required`|[Changefeed mode](https://ydb.tech/ru/docs/yql/reference/syntax/alter_table#changefeed-options)|
|format|`string`<br>`required`|Changefeed format|
|virtual_timestamps|`bool`<br>`optional`|Using [virtual timestamps](https://ydb.tech/ru/docs/concepts/cdc#virtual-timestamps)|
|retention_period|`string`<br>`optional`|Time of data retention in the topic, [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601) format|
|consumer|`array[consumer]`<br>`optional`|Changefeed consumers|

When initializing the `"yandex_ydb_table_changefeed"` resource, you can specify a single connection parameter: `connection_string`, `table_path`, or `table_id`. If you specify multiple connection parameters, they will come into conflict. For this reason, specify a single connection parameter. For example, `table_id` with a relative link in the format: `<resource>.<ID>.<parameter>`: `yandex_ydb_table.test_table_2.id`.

Inside the changefeed resource resides the `consumer` section. [Consumer](https://ydb.tech/ru/docs/concepts/topic#consumer) is a named entity for reading data from the topic. The consumer has several parameters, the main one of which is the consumer `name`. When initializing the `"yandex_ydb_table_changefeed"` resource, you can set up multiple consumers or create none, in which case you will not be able to read data from the changefeed.

Here is the full list of `consumer` parameters:
| **Field name** | **Type** | **Description** |
| --- | --- | --- |
| name | `string`<br>`required` | Consumer name |
| supported_codecs | `array[string]`<br>`optional` | Supported data encodings |
| starting_message_timestamp_ms | `integer`<br>`optional` | Timestamp in the UNIX timestamp format, from which the consumer will start reading data |

The consumer name is used in the SDK or CLI to [read data](https://ydb.tech/ru/docs/best_practices/cdc#read) from the topic.