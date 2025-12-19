---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/DB_CALL_AGG_INT.md
---

# DB_CALL_AGG_INT



#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  DB_CALL_AGG_INT( db_agg_function_name [ , arg_1 [ , arg_2 [ , ... ] ] ] )
  ```

- Extended

  ```
  DB_CALL_AGG_INT( db_agg_function_name [ , arg_1 [ , arg_2 [ , ... ] ] ]
                   [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
                   [ BEFORE FILTER BY ... ]
                 )
  ```

  More info:
  - [FIXED, INCLUDE, EXCLUDE](native-functions.md#syntax-lod)
  - [BEFORE FILTER BY](native-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}

{% note warning %}

The availability and behavior of native functions depends on your database type and version.

It is recommended to use native functions only if there is no supported {{ datalens-short-name }} function (composition of functions) that can achieve the required result.

{% endnote %}

Calls a native database aggregate function by its name. Native function should return a value of type `Integer`. The function is executed as an aggregation across grouped rows.

The first argument `db_agg_function_name` must be a constant string with the name of the database function to call. All subsequent arguments are passed to the native function in the same order as written in the formula and can be of any type, including types that are not currently supported by {{ datalens-short-name }}.

The function name must contain only alphanumeric characters, underscore and colon characters.

**Argument types:**
- `db_agg_function_name` — `String`
- `arg_1` — `Any`
- `arg_2` — `Any`


**Return type**: `Integer`

{% note info %}

Only constant values are accepted for the arguments (`db_agg_function_name`).

{% endnote %}


#### Example {#examples}

```
DB_CALL_AGG_INT("uniqMerge", [uniqStateField]) -- ClickHouse: merge uniqState aggregations to get unique count
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Trino`, `YDB`.
