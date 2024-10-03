---
title: Managing {{ ydb-short-name }} topic configurations
description: This guide describes properties of the `yandex_ydb_table` resource for managing {{ ydb-short-name }} topic configurations.
---

# Managing {{ ydb-short-name }} topic configurations

To work with [topics](https://ydb.tech/docs/ru/concepts/topic), use the `yandex_ydb_topic` resource.

{% note info %}

We recommend creating a topic in a separate folder. A topic in the database root visually breaks the database structure.

{% endnote %}

## Description of the `yandex_ydb_topic` resource {#yandex_ydb_topic_description}

`yandex_ydb_topic` resource use case:

```tf
resource "yandex_ydb_topic" "ydb_topic" {
  database_endpoint = yandex_ydb_database_serverless.database1.ydb_full_endpoint  # example of connecting to a DB
  name              = "test_dir/test_topic"
  supported_codecs  = ["zstd"]

  consumer {
    name             = "test-consumer1"
    starting_message_timestamp_ms = 0
    supported_codecs = ["zstd","raw"]
  }

  consumer {
    name             = "test-consumer2"
    starting_message_timestamp_ms = 2000
    supported_codecs = ["zstd"]
  }

  consumer {
    name             = "test-consumer3"
    starting_message_timestamp_ms = 0
    supported_codecs = ["zstd"]
  }
}
```

The following fields are supported:
| **Field name** | **Type** | **Description** |
| --- | --- | --- |
|`name`|`string`<br>`required`|Topic name|
|`database_endpoint`|`string`<br>`required`|Full path to the database|
|`retention_period_ms`|`number`<br>`optional`|Data retention period in milliseconds; the default value is `86400000` (24 hours)|
|`partitions_count`|`number`<br>`optional`|Number of partitions; the default value is `2`|
|`supported_codecs`|`list(string)`<br>`optional`|Supported data compression codecs; the default value is `gzip, raw, zstd`.<br>You can combine them|
|`consumer`|`consumer`|Topic consumers|

{% note info %}

You can create, but cannot delete a consumer using {{ TF }}. You can delete a consumer using the [management console]({{ link-console-main }}) or [{{ ydb-short-name }} CLI](https://ydb.tech/docs/en/reference/ydb-cli/install).

{% endnote %}

Data [consumer](https://ydb.tech/docs/ru/concepts/topic#consumer) description:
| **Field name** | **Type** | **Description** |
| --- | --- | --- |
|`name`|`string`<br>`required`|Consumer name|
|`supported_codecs`|`list(string)`<br>`optional`|Supported data compression codecs; the default value is `gzip, raw, zstd`. You can combine them|
|`starting_message_timestamp_ms`|`number`<br>`optional`|Timestamp in [UNIX timestamp](https://ru.wikipedia.org/wiki/Unix-время) format, in milliseconds, from which the consumer will start reading data; the default value is 0, i.e., from the start of delivery|
