---
title: Creating secondary indexes in {{ ydb-short-name }} row-based tables
description: This tutorial describes properties of the `yandex_ydb_table_index` resource for creating secondary indexes in {{ ydb-short-name }} row-based tables.
---

# Creating secondary indexes in row-based tables

To work with a [table index](https://ydb.tech/docs/ru/concepts/secondary_indexes), use the `yandex_ydb_table_index` resource.

{% note info %}

When modifying a secondary index, the old index is deleted and a new one is created.

{% endnote %}

## Description of the `yandex_ydb_table_index` resource {#ttable_index_description}

`yandex_ydb_table_index` resource use case:

```tf
resource "yandex_ydb_table_index" "ydb_table_index" {
  table_path        = "test_dir/test_table_3_col" # example of a path relative to the database root
  connection_string = yandex_ydb_database_serverless.database1.ydb_full_endpoint # example of connecting to the DB
  name              = "my_index"
  type              = "global_sync" # "global_async"
  columns           = ["a", "b"]
  cover             = ["c"]
}
```

The following fields are supported:

| **Field name** | **Type** | **Description** |
| --- | --- | --- |
|`table_path`|`string`|Path to the table. It is specified if `table_id` is not set.|
|`connection_string`|`string`|Database connection string. It is specified if `table_id` is not set.|
|`table_id`|`string`|{{ TF }} ID of the table. It is specified if `table_path` or `connection_string` is not set.|
|`name`|`string`<br>`required`|Index name|
|`type`|`string`<br>`required`|Index type [global_sync / global_async](https://ydb.tech/docs/ru/yql/reference/syntax/create_table#secondary_index)|
|`columns`|`list(string)`<br>`required`|Ordered list of index column names|
|`cover`|`list(string)`<br>`required`|List of additional columns for the covering index|
