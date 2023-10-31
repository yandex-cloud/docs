# Creating row-based tables in a database


{% note warning %}

Currently, the service only supports creating row-based tables. The Terraform provider functionality for creating column-based tables is under development.

{% endnote %}


In the Terraform context, a table is also a resource. That is why, we describe database tables by independent sections (`resource "yandex_ydb_table"`), specifying an internal link to the previously created database. To the database you created, add a test row-based table of three columns:
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

    primary_key = ["a","b”]

}
```

Here are the values of the `"yandex_ydb_table"` section parameters:
1. `path`: Database path where the table will be created. The table name is specified without the trailing slash `/`. If the directory where the table is created does not exist, it will be created.
1. `connection_string`: Path to connect to the database. It is used together with the `ydb_full_endpoint` parameter, which contains the full path to the database: `grpcs://ydb.serverless.yandexcloud.net:2135/?database=/ru-central1/b1gv7kfcttiop2s874m6/etn66ecf1qbto40intpl`. For brevity and simplicity, you can use a link to the `"yandex_ydb_database_serverless"` resource, specifying the ID and the `ydb_full_endpoint` parameter, e.g., `yandex_ydb_database_serverless.database1.ydb_full_endpoint`.
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

In the `"yandex_ydb_table"` section, there are nested column sections to describe individual column properties, such as:
| **Field name** | **Type** | **Description** |
| --- | --- | --- |
|name|`string`<br>|`required`|Column name|
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

Currently, you cannot delete a column with the help of Terraform, you can only add one. To delete a column, first delete it at the database level (for example, using a YQL query), then remove the column from the configuration file.

{% endnote %}

You can group columns into [families](https://ydb.tech/ru/docs/yql/reference/syntax/create_table#column-family) to set shared parameters for them, such as:
* `DATA`: Type of storage device for column data in this group (acceptable values: `ssd`, `rot` (from HDD spindle rotation)).
* `COMPRESSION`: Data codec (acceptable values: `off`, `lz4`).
   To group columns into a family, add a `family` section at the same level with the column `section`:
```tf
family {
  name        = "my_family"
  data        = "ssd"
  compression = "lz4"
}
```

`Family` section fields description:
| **Field name** | **Type** | **Description** |
| --- | --- | --- |
|name|`string`<br>`required`|Column group name|
|data|`string`<br>`required`|Device type for storing columns of this group|
|compression|`string`<br>`required`|Data codec|

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

YDB allows you to create a special column type, i.e., a [TTL column](https://ydb.tech/en/docs/concepts/ttl), whose values determine the time-to-live for rows. TTL automatically deletes the item from your table once the specified number of seconds passes after the time set in the TTL column. You can define only a single TTL column. Here are the possible TTL column types: `Date`, `Datetime`, `Timestamp`, `Uint32`, `Uint64`, and `DyNumber`.

The TTL column is configured by the following section:
```tf
ttl {
  column_name     = "d"
  expire_interval = "PT1H" # 1 hour
}
```

TTL fields description:
| **Field name** | **Type** | **Description** |
| --- | --- | --- |
|column_name|`string`<br>`required`|Column name for TTL|
|expire_interval|`string`<br>`required`|Interval in the [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601) format|
