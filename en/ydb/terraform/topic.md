---
title: Managing {{ydb-short-name}} topic configurations
description: This guide describes the properties of the `yandex_ydb_topic` resource for managing {{ydb-short-name}} topic configurations.
---

# Managing {{ ydb-short-name }} topic configurations

For operations with [topics]({{ ydb.docs }}/concepts/topic), use the `yandex_ydb_topic` resource.

{% note info %}

We recommend creating a topic in a separate folder. A topic in the database root visually breaks the database structure.

{% endnote %}

## Description of the yandex_ydb_topic resource {#yandex_ydb_topic_description}

Usage example for `yandex_ydb_topic`:

```tf
resource "yandex_ydb_topic" "ydb_topic" {
  database_endpoint = yandex_ydb_database_serverless.database1.ydb_full_endpoint  # DB connection example
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
|`database_endpoint`|`string`<br>`required`|Full database path|
|`retention_period_ms`|`number`<br>`optional`|Data retention period, in ms. Default value: `86400000` (full day)|
|`partitions_count`|`number`<br>`optional`|Number of partitions; default: `2`|
|`supported_codecs`|`list(string)`<br>`optional`|Supported data compression codecs; default: `"gzip", "raw", "zstd"`.<br>Can be combined as needed.|
|`consumer`|`consumer`|Topic consumers|

{% note info %}

You can create but cannot delete a consumer using {{ TF }}. You can delete a consumer using the [management console]({{ link-console-main }}) or [{{ ydb-short-name }} CLI]({{ ydb.docs }}/reference/ydb-cli/install).

{% endnote %}

Data [consumer]({{ ydb.docs }}/concepts/topic#consumer) description:
| **Field name** | **Type** | **Description** |
| --- | --- | --- |
|`name`|`string`<br>`required`|Reader name|
|`supported_codecs`|`list(string)`<br>`optional`|Supported data compression codecs; default: `"gzip", "raw", "zstd"`. Can be combined as needed.|
|`starting_message_timestamp_ms`|`number`<br>`optional`|[UNIX timestamp](https://ru.wikipedia.org/wiki/Unix-время), in ms, the consumer will start reading data from. The default is `0`, i.e., from start of delivery.|