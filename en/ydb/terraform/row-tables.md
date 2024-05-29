---
title: "Creating row-based tables in a {{ ydb-short-name }} database"
description: "This tutorial describes properties of the `yandex_ydb_table` resource for creating row-based tables in {{ ydb-short-name }}."
---

# Creating row-based tables in a database


{% note warning %}

Currently, the service only supports creating row-based tables. The {{ TF }} provider functionality for creating column-based tables is under development.

{% endnote %}


In the {{ TF }} context, a table is a resource. That is why, we describe database tables in independent sections (`resource "yandex_ydb_table"`), specifying an internal link to the previously created database.

## Description of the `yandex_ydb_table` resource {#ydb_table_description}

Example of creating a test row-based table with three columns in an existing database:
```tf
resource "yandex_ydb_table" "test_table" {
  path = "test_dir/test_table_3_col"
  connection_string = yandex_ydb_database_serverless.database1.ydb_full_endpoint

column {
      name = "a"
      type = "Utf8"
      not_null = true
    }
    column {
      name = "b"
      type = "Uint32"
      not_null = true
    }
    column {
      name = "c"
      type = "Int32"
      not_null = false
    }
    column {
    name = "d"
    type = "Timestamp"
    }

  primary_key = ["a","b"]

}
```

Properties of the `yandex_ydb_table` resource fields:
1. `path`: Path within the database to include the table being created. The table name is specified without the trailing slash (`/`). If there is no directory to host the table, it will be created automatically.
1. `connection_string`: Path to connect to the database. It is used together with the `ydb_full_endpoint` parameter, which contains the full path to the database: `grpcs://ydb.serverless.yandexcloud.net:2135/?database=/{{ region-id }}/b1gv7kfcttio********/etn66ecf1qbt********`. For brevity and simplicity, you can use a link to the `yandex_ydb_database_serverless` resource specifying the ID and the `ydb_full_endpoint` parameter, e.g., `yandex_ydb_database_serverless.database1.ydb_full_endpoint`.
1. `primary_key`: Primary key of the table. The key can be composite.

Full list of fields in the `yandex_ydb_table` resource:
| **Field name** | **Type** | **Value** | **Description** |
| --- | --- | --- | --- |
|path|`string`|`required`|Table path|
|connection_string|`string`|`required`|Connection string|
|column|`array[column]`|`required`|Column data type|
|family|`array[family]`|`optional`|Column group|
|primary_key|`array[string]`|`required`|[Table primary key](https://ydb.tech/ru/docs/yql/reference/syntax/create_table)|
|ttl|`ttl`|`optional`|TTL settings|
|attributes|`map[string]string`|`optional`|Table attributes|
|partitioning_settings|`partitioning_settings`|`optional`|Partitioning settings|
|key_bloom_filter|`boolean`|`optional`|Using the [Bloom filter for the primary key](https://ydb.tech/ru/docs/concepts/datamodel/table#bloom-filter)|
|read_replicas_settings|`string`|`optional`|[Read replication settings](https://ydb.tech/ru/docs/concepts/datamodel/table#read_only_replicas)|

In the `yandex_ydb_table` section, there are nested `column` sections to describe individual column properties, such as:
| **Field name** | **Type** | **Description** |
| --- | --- | --- |
|name|`string`<br>`required`|Column name|
|type|`string`<br>`required`|Column data type. [YQL data types](https://ydb.tech/ru/docs/yql/reference/types/) are used.|
|family|`string`<br>`optional`|Column group|
|not_null|`boolean`<br>`optional`<br>Default: `false`|A column cannot have the NULL data type.|

Example of a full column description:
```tf
column {
  name     = "column_name"
  type     = "Utf8"
  family   = "some_family"
  not_null = true
}
```

{% note warning %}

Currently, you cannot delete a column using {{ TF }}, you can only add one. To delete a column, first delete it at the database level (for example, using a YQL query), then remove the column from the configuration file.

{% endnote %}

You can group columns into [families](https://ydb.tech/ru/docs/yql/reference/syntax/create_table#column-family) to set shared parameters for them, such as the following:
* `DATA`: Type of storage device for column data in this family (acceptable values: `ssd`, `rot` (from HDD spindle rotation)).
* `COMPRESSION`: Data codec (acceptable values: `off`, `lz4`).

To group columns into a family, add the `family` section at the same level with the `column` section:
```tf
family {
  name        = "my_family"
  data        = "ssd"
  compression = "lz4"
}
```

`family` section fields description:
| **Field name** | **Type** | **Description** |
| --- | --- | --- |
|name|`string`<br>`required`|Column group name|
|data|`string`<br>`required`|Data storage device type for columns of this group|
|compression|`string`<br>`required`|Data compression codec|

Here is an example of grouping two columns into a family:
```tf
resource "yandex_ydb_table" "test_table" {
    path = "test_dir/test_table_3_col"
    connection_string = yandex_ydb_database_serverless.database1.ydb_full_endpoint
    column {
        name = "a"
        type = "Uint16"
        family = "test_family_group"
        not_null = true
    }
    column {
        name = "b"
        type = "Uint32"
        family = "test_family_group"
        not_null = true
    }
    family {
      name  = "test_family_group"
      data  = "ssd"
      compression = "lz4"
    }    
}
```

{{ ydb-short-name }} allows you to create a [TTL column](https://ydb.tech/en/docs/concepts/ttl), i.e., a special column type, whose values determine the time-to-live for rows. The TTL mechanism automatically deletes the item from your table after the specified number of seconds elapses from the time set in the TTL column. You can define only a single TTL column. Here are the possible TTL column types: `Date`, `Datetime`, `Timestamp`, `Uint32`, `Uint64`, and `DyNumber`.

The TTL column is configured by the following section:
```tf
ttl {
  column_name     = "d"
  expire_interval = "PT1H" # 1 hour
  unit            = "seconds" # for numeric column types (non ISO 8601)
}
```

`ttl` fields description:
| **Field name** | **Type** | **Description** |
| --- | --- | --- |
|column_name|`string`<br>`required`|TTL column name|
|expire_interval|`string`<br>`required`|Interval in [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601) format|
|unit|`string`<br>`optional`|It is set if the TTL column is of the [numeric type](https://ydb.tech/docs/ru/yql/reference/types/primitive#numeric). It supports the following values: `seconds`, `milliseconds`, `microseconds`, and `nanoseconds`.|

## Partitioning row-based tables

[Partitioning](https://ydb.tech/docs/ru/concepts/datamodel/table#partitioning_row_table) is splitting table data into parts to improve query performance and optimize data management. For partitioning row-based {{ ydb-short-name }} tables in {{ TF }}, use the `partitioning_settings` parameter of the `yandex_ydb_table` resource.

### Description of the `partitioning_settings` section fields

Example:
```tf
resource "yandex_ydb_table" "test_table" {
  path = "/test_dir/test_table_3_col"
  connection_string = yandex_ydb_database_serverless.database1.ydb_full_endpoint

  partitioning_settings {
    auto_partitioning_min_partitions_count = 5
    auto_partitioning_max_partitions_count = 8
    auto_partitioning_partition_size_mb    = 256
    auto_partitioning_by_load              = true
    ...
  }
 ...
}
```

Full description of the `partitioning_settings` fields:
| **Field name** | **Type** | **Description** |
| --- | --- | --- |
|uniform_partitions|`number`<br>`optional`|Number of [pre-allocated partitions](https://ydb.tech/docs/ru/concepts/datamodel/table#uniform_partitions)|
|partition_at_keys|`string`<br>`optional`|[Partitioning by primary key](https://ydb.tech/docs/ru/concepts/datamodel/table#partition_at_keys)|
|auto_partitioning_min_partitions_count|`number`<br>`optional`|Minimum possible [number of partitions](https://ydb.tech/docs/ru/concepts/datamodel/table#auto_partitioning_min_partitions_count) for auto-partitioning|
|auto_partitioning_max_partitions_count|`number`<br>`optional`|Maximum possible [number of partitions](https://ydb.tech/docs/ru/concepts/datamodel/table#auto_partitioning_max_partitions_count) for auto-partitioning|
|auto_partitioning_partition_size_mb|`number`<br>`optional`|Setting the value for [auto-partitioning by size](https://ydb.tech/docs/ru/concepts/datamodel/table#auto_partitioning_partition_size_mb) in megabytes|
|auto_partitioning_by_size_enabled|`bool`<br>`optional`|Enabling auto-partitioning by size (bool) which is enabled by default (true).|
|auto_partitioning_by_load|`bool`<br>`optional`|Enabling auto-partitioning by load (bool) which is disabled by default (false).|
