---
title: Creating secondary indexes in {{ ydb-short-name }} row-oriented tables
description: This tutorial describes the properties of the `yandex_ydb_table_index` resource for creating secondary indexes in {{ ydb-short-name }} row-oriented tables.
---

# Creating secondary indexes in row-oriented tables

For operations with a [table index]({{ ydb.docs }}/concepts/secondary_indexes), use the `yandex_ydb_table_index` resource.

{% note info %}

Updating a secondary index deletes the old index and creates a new one.

{% endnote %}

## Description of the yandex_ydb_table_index resource {#ttable_index_description}

Usage example for `yandex_ydb_table_index`:

```tf
resource "yandex_ydb_table_index" "ydb_table_index" {
  table_path        = "test_dir/test_table_3_col" # path example relative to the database root
  connection_string = yandex_ydb_database_serverless.database1.ydb_full_endpoint # database connection example
  name              = "my_index"
  type              = "global_sync" # "global_async"
  columns           = ["a", "b"]
  cover             = ["c"]
}
```

The following fields are supported:
| **Field name** | **Type** | **Description** |
| --- | --- | --- |
|`table_path`|`string`|Table path. It is specified if `table_id` is not set.|
|`connection_string`|`string`|Database connection string. It is specified if `table_id` is not set.|
|`table_id`|`string`|{{ TF }} ID of the table. It is specified if neither `table_path` nor `connection_string` is set.|
|`name`|`string`<br>`required`|Index name.|
|`type`|`string`<br>`required`|[global_sync / global_async]({{ ydb.docs }}/yql/reference/syntax/create_table#secondary_index) index type.|
|`columns`|`list(string)`<br>`required`|Ordered list of names of columns included in the index.|
|`cover`|`list(string)`<br>`required`|List of additional columns for the covering index.|