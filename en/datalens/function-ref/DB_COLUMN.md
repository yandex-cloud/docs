---
editable: false
---

# DB_COLUMN



#### Syntax {#syntax}


```
DB_COLUMN( column_name )
```

#### Description {#description}

{% note warning %}

The availability and behavior of native functions depends on your database type and version.

It is recommended to use native functions only if there is no supported {{ datalens-short-name }} function (composition of functions) that can achieve the required result.

{% endnote %}

Returns a native database column by its name. Supported column names and their result types are defined by the connector.

The argument `column_name` must be a constant string with one of the values supported by the connector. For ClickHouse, all results have type `String` and the supported values are:
`"_table"`, `"_partition_id"`, `"_file"`, `"_path"`.

Unlike DB_CALL_* formulas, this formula emits a column reference, not a function call. On ClickHouse, virtual-column availability depends on the table engine and server version: `_partition_id` belongs to the MergeTree family, `_table` to the Merge engine/table function, and `_file` / `_path` to File/S3.

**Argument types:**
- `column_name` — `String`


**Return type**: `String`

{% note info %}

Only constant values are accepted for the arguments (`column_name`).

{% endnote %}


#### Examples {#examples}

```
DB_COLUMN("_partition_id") -- ClickHouse MergeTree: virtual partition id
```

```
DB_COLUMN("_table") -- ClickHouse Merge: source table name
```

```
DB_COLUMN("_file") -- ClickHouse File/S3: source file name
```

```
DB_COLUMN("_path") -- ClickHouse File/S3: source file path
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`.
