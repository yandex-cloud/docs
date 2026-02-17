---
subcategory: Managed Service for YDB
---

# yandex_ydb_table (Resource)

Yandex Database table.

## Example usage

```terraform
//
// Create a new row-oriented YDB Table.
//
resource "yandex_ydb_table" "test_table" {
  path              = "test_dir/test_table_3_col"
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
}
```
```terraform
//
// Create a new column-oriented YDB Table.
//
resource "yandex_ydb_table" "test_table" {
  path              = "test_dir/test_table_3_col"
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

## Arguments & Attributes Reference

- `attributes` (Map Of String). A map of table attributes.
- `connection_string` (**Required**)(String). Connection string for database.
- `id` (String). 
- `key_bloom_filter` (Bool). Use the Bloom filter for the primary key.
- `path` (**Required**)(String). Table path.
- `primary_key` (**Required**)(List Of String). A list of table columns to be used as primary key.
- `read_replicas_settings` (String). Read replication settings.
- `store` (String). Table storage type. Set to `column` for column-oriented tables. Omit for row-oriented tables (default).
- `column` [Block]. A list of column configuration options.
  - `family` (String). Column group.
  - `name` (**Required**)(String). Column name.
  - `not_null` (Bool). A column cannot have the NULL data type. Default: `false`.
  - `type` (**Required**)(String). Column data type. YQL data types are used.
- `family` [Block]. A list of column group configuration options. The `family` block may be used to group columns into [families](https://ydb.tech/en/docs/yql/reference/syntax/create_table#column-family) to set shared parameters for them.
  - `compression` (**Required**)(String). Data codec (acceptable values: off, lz4).
  - `data` (**Required**)(String). Type of storage device for column data in this group (acceptable values: ssd, rot (from HDD spindle rotation)).
  - `name` (**Required**)(String). Column family name.
- `partitioning_settings` [Block]. Table partitioning settings.
  - `auto_partitioning_by_load` (Bool). 
  - `auto_partitioning_by_size_enabled` (Bool). 
  - `auto_partitioning_max_partitions_count` (Number). 
  - `auto_partitioning_min_partitions_count` (Number). 
  - `auto_partitioning_partition_size_mb` (Number). 
  - `partition_by` (List Of String). Partitioning keys constitute a subset of the table's primary keys. If not set, primary keys will be used.
  - `uniform_partitions` (Number). 
  - `partition_at_keys` [Block]. 
    - `keys` (**Required**)(List Of String). 
- `ttl` [Block]. The `TTL` block supports allow you to create a special column type, [TTL column](https://ydb.tech/en/docs/concepts/ttl), whose values determine the time-to-live for rows.
  - `column_name` (**Required**)(String). Column name for TTL.
  - `expire_interval` (**Required**)(String). Interval in the ISO 8601 format.
  - `unit` (String).

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_ydb_table.<resource Name> <resource Id>
terraform import yandex_ydb_table.test_table ...
```
