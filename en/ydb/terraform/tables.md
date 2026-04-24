---
title: Creating row-oriented and column-oriented tables in a {{ ydb-short-name }} database.
description: This guide describes the properties of the yandex_ydb_table resource used to create row-oriented and column-oriented tables in {{ ydb-short-name }}.
---

# Creating row-oriented and column-oriented tables in a database

{{ TF }} treats a table as a resource. Therefore, we describe database tables in independent sections (`resource "yandex_ydb_table"`), specifying an internal link to the previously created database.

## Description of the yandex_ydb_table resource {#ydb_table_description}

Example of creating a 4-column test table in an existing database:

{% list tabs %}

- Row-oriented table

    ```tf
    resource "yandex_ydb_table" "test_table" {
      path = "test_dir/test_table_4_col"
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

- Column-oriented table

    ```tf
    resource "yandex_ydb_table" "test_table" {
      path              = "test_dir/test_table_4_col"
      connection_string = yandex_ydb_database_serverless.database1.ydb_full_endpoint

      column {
        name     = "a"
        type     = "Utf8"
        not_null = true
      }
      column {
        name     = "b"
        type     = "Uint32"
        not_null = true
      }
      column {
        name     = "c"
        type     = "Int32"
        not_null = false
      }
      column {
        name = "d"
        type = "Timestamp"
      }

      primary_key = ["a", "b"]

      store = "column"

      partitioning_settings {
        partition_by = ["b", "a"]
      }
    }
    ```

{% endlist %}

Properties of the `yandex_ydb_table` resource fields:
1. `path`: Path to the table in the database. Specify the table name without the trailing slash, `/`. If there is no directory for the table, it will be created automatically.
1. `connection_string`: Path for connecting to the database. It is used together with the `ydb_full_endpoint` parameter that contains the full database path: `grpcs://ydb.serverless.yandexcloud.net:2135/?database=/{{ region-id }}/b1gv7kfcttio********/etn66ecf1qbt********`. For brevity and simplicity, you can use a link to the `"yandex_ydb_database_serverless"` resource with the ID and the `ydb_full_endpoint` parameter specified, e.g., `yandex_ydb_database_serverless.database1.ydb_full_endpoint`.
1. `primary_key`: Primary key of the table. The key can be composite.

Full list of the `yandex_ydb_table` resource fields:
| **Field name** | **Type** | **Value** | **Description** |
| --- | --- | --- | --- |
|path|`string`|`required`|Table path.|
|connection_string|`string`|`required`|Connection string.|
|column|`array[column]`|`required`|`Column` data type.|
|family|`array[family]`|`optional`|Column family.|
|store|`string`|`optional`|Table type. To create a column-oriented table, specify `column`. To create a row-oriented table, do not specify the `store` field.|
|primary_key|`array[string]`|`required`|[Primary key of the table]({{ ydb.docs }}/yql/reference/syntax/create_table).|
|ttl|`ttl`|`optional`|TTL settings.|
|attributes|`map[string]string`|`optional`|Table attributes.|
|partitioning_settings|`partitioning_settings`|`optional`|Partitioning settings.|
|key_bloom_filter|`boolean`|`optional`|Using the [Bloom filter for the primary key]({{ ydb.docs }}/concepts/datamodel/table#bloom-filter).|
|read_replicas_settings|`string`|`optional`|[Settings for reading data from replicas]({{ ydb.docs }}/concepts/datamodel/table#read_only_replicas).|

The `yandex_ydb_table` section contains nested `column` sections describing individual column properties, such as:
| **Field name** | **Type** | **Description** |
| --- | --- | --- |
|name|`string`<br>`required`|Column name.|
|type|`string`<br>`required`|Column data type. [YQL data types]({{ ydb.docs }}/yql/reference/types/) are used.|
|family|`string`<br>`optional`|Column family.|
|not_null|`boolean`<br>`optional`<br>The default value is `false`.|The column cannot be NULL.|

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

Currently, you cannot delete a column using {{ TF }}; you can only add one. To delete a column, first delete it in the database (e.g., using a YQL query), then remove it from the configuration file.

{% endnote %}

You can group columns into [families]({{ ydb.docs }}/yql/reference/syntax/create_table#column-family) to set shared fields for them, such as the following:
* `DATA`: Type of storage device for column data in this family. The acceptable values are `ssd` and `rot` (named after HDD spindle rotation).
* `COMPRESSION`: Data compression codec. The acceptable values are `off` and `lz4`.

To group columns into a family, add the `family` section at the same level as the `column` section:
```tf
family {
  name        = "my_family"
  data        = "ssd"
  compression = "lz4"
}
```

Descriptions of the `family` section fields:
| **Field name** | **Type** | **Description** |
| --- | --- | --- |
|name|`string`<br>`required`|Column family name.|
|data|`string`<br>`required`|Storage device type for the data in this column family.|
|compression|`string`<br>`required`|Data compression codec.|

Here is an example of grouping two columns into a family:
```tf
resource "yandex_ydb_table" "test_table" {
    path = "test_dir/test_table"
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

{{ ydb-short-name }} allows you to create a [TTL column]({{ ydb.docs }}/concepts/ttl), i.e., a special column type, whose values determine the time-to-live for rows. The TTL mechanism automatically deletes the row from your table after the specified number of seconds elapses from the time set in the TTL column. You can only define a single TTL column. A TTL column can be one of the following types: `Date`, `Datetime`, `Timestamp`, `Uint32`, `Uint64`, `DyNumber`.

The TTL column is described in the following section:
```tf
ttl {
  column_name     = "d"
  expire_interval = "PT1H" # 1 hour
  unit            = "seconds" # For numeric column types (non ISO 8601)
}
```

Description of the `ttl` field values:
| **Field name** | **Type** | **Description** |
| --- | --- | --- |
|column_name|`string`<br>`required`|TTL column name.|
|expire_interval|`string`<br>`required`|Time in [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601) format.|
|unit|`string`<br>`optional`|It is specified if the TTL column is of [numeric]({{ ydb.docs }}/yql/reference/types/primitive#numeric) type. The supported values are `seconds`, `milliseconds`, `microseconds`, `nanoseconds`.|

## Partitioning row-oriented tables

[Partitioning]({{ ydb.docs }}/concepts/datamodel/table#partitioning_row_table) is splitting table data into parts to improve query performance and optimize data management. For partitioning row-oriented {{ ydb-short-name }} tables in {{ TF }}, use the `partitioning_settings` parameter of the `yandex_ydb_table` resource.

### Description of the `partitioning_settings` section fields

Here is an example:
```tf
resource "yandex_ydb_table" "test_table" {
  path = "/test_dir/test_table_4_col"
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

Full description of the `partitioning_settings` fields for row-oriented tables:
| **Field name** | **Type** | **Description** |
| --- | --- | --- |
|uniform_partitions|`number`<br>`optional`|Number of [pre-allocated partitions]({{ ydb.docs }}/concepts/datamodel/table#uniform_partitions).|
|partition_at_keys|`string`<br>`optional`|[Partitioning by primary key]({{ ydb.docs }}/concepts/datamodel/table#partition_at_keys).|
|auto_partitioning_min_partitions_count|`number`<br>`optional`|Minimum possible [number of partitions]({{ ydb.docs }}/concepts/datamodel/table#auto_partitioning_min_partitions_count) for auto partitioning.|
|auto_partitioning_max_partitions_count|`number`<br>`optional`|Maximum possible [number of partitions]({{ ydb.docs }}/concepts/datamodel/table#auto_partitioning_max_partitions_count) for auto partitioning.|
|auto_partitioning_partition_size_mb|`number`<br>`optional`|Setting [auto partitioning by size]({{ ydb.docs }}/concepts/datamodel/table#auto_partitioning_partition_size_mb) in MB.|
|auto_partitioning_by_size_enabled|`bool`<br>`optional`|Auto partitioning by size (`bool`); enabled by default (`true`).|
|auto_partitioning_by_load|`bool`<br>`optional`|Auto partitioning by load (`bool`); disabled by default (`false`).|

## Partitioning column-oriented tables

[Partitioning]({{ ydb.docs }}/concepts/datamodel/table#olap-tables-partitioning) is splitting table data into parts to improve query performance and optimize data management. Unlike YDB row-oriented tables, column-oriented tables split data using special partition keys rather than primary keys. Partition keys are a subset of the table's primary keys.

In {{ TF }}, column-oriented tables are partitioned using the parameters in the `partitioning_settings` section of the `yandex_ydb_table` resource.

Here is an example:
```tf
resource "yandex_ydb_table" "test_table" {
    path              = "test_dir/test_table_4_col"
    connection_string = yandex_ydb_database_serverless.database1.ydb_full_endpoint

    ...

    partitioning_settings {
        partition_by = ["b", "a"]
    }
}
```

Description of the `partitioning_settings` fields for column-oriented tables:
| **Field name** | **Type** | **Description** |
| --- | --- | --- |
|partition_by|`string`<br>`optional`|Partitioning based on specified partition keys.|
|auto_partitioning_min_partitions_count|`number`<br>`optional`|[Number of partitions]({{ ydb.docs }}/concepts/datamodel/table#auto_partitioning_min_partitions_count) for data storage. The default value is 64.|