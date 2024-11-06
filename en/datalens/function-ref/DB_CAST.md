---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/DB_CAST.md
---

# DB_CAST



#### Syntax {#syntax}


```
DB_CAST( expression, native_type [ , param_1 [ , param_2 ] ] )
```

#### Description {#description}
Converts the `expression` expression to database's native type `native_type`.

The following type casts are supported:

| Data source   | Data type                     | Native data type      | Parameters for native type   | Comment                       |
|:--------------|:------------------------------|:----------------------|:-----------------------------|:------------------------------|
| `ClickHouse`  | `Date`                        | `Date`                |                              |                               |
| `ClickHouse`  | `Date`                        | `Date32`              |                              |                               |
| `ClickHouse`  | `Fractional number`           | `Float32`             |                              |                               |
| `ClickHouse`  | `Fractional number`           | `Float64`             |                              |                               |
| `ClickHouse`  | `Fractional number`           | `Decimal`             | `Integer`, `Integer`         |                               |
| `ClickHouse`  | `Integer`                     | `Int8`                |                              |                               |
| `ClickHouse`  | `Integer`                     | `Int16`               |                              |                               |
| `ClickHouse`  | `Integer`                     | `Int32`               |                              |                               |
| `ClickHouse`  | `Integer`                     | `Int64`               |                              |                               |
| `ClickHouse`  | `Integer`                     | `UInt8`               |                              |                               |
| `ClickHouse`  | `Integer`                     | `UInt16`              |                              |                               |
| `ClickHouse`  | `Integer`                     | `UInt32`              |                              |                               |
| `ClickHouse`  | `Integer`                     | `UInt64`              |                              |                               |
| `ClickHouse`  | `String`                      | `String`              |                              |                               |
| `PostgreSQL`  | `Array of fractional numbers` | `double precision[]`  |                              |                               |
| `PostgreSQL`  | `Array of fractional numbers` | `real[]`              |                              |                               |
| `PostgreSQL`  | `Array of fractional numbers` | `numeric[]`           | `Integer`, `Integer`         |                               |
| `PostgreSQL`  | `Array of integers`           | `smallint[]`          |                              |                               |
| `PostgreSQL`  | `Array of integers`           | `integer[]`           |                              |                               |
| `PostgreSQL`  | `Array of integers`           | `bigint[]`            |                              |                               |
| `PostgreSQL`  | `Array of strings`            | `text[]`              |                              |                               |
| `PostgreSQL`  | `Array of strings`            | `character varying[]` |                              |                               |
| `PostgreSQL`  | `Array of strings`            | `varchar[]`           |                              |                               |
| `PostgreSQL`  | `Fractional number`           | `double precision`    |                              |                               |
| `PostgreSQL`  | `Fractional number`           | `real`                |                              |                               |
| `PostgreSQL`  | `Fractional number`           | `numeric`             | `Integer`, `Integer`         |                               |
| `PostgreSQL`  | `Integer`                     | `smallint`            |                              |                               |
| `PostgreSQL`  | `Integer`                     | `integer`             |                              |                               |
| `PostgreSQL`  | `Integer`                     | `bigint`              |                              |                               |
| `PostgreSQL`  | `String`                      | `text`                |                              |                               |
| `PostgreSQL`  | `String`                      | `character`           | `Integer`                    | Alias: `char`                 |
| `PostgreSQL`  | `String`                      | `character varying`   | `Integer`                    | Alias: `varchar`              |
| `PostgreSQL`  | `String`                      | `char`                | `Integer`                    | Alias for `character`         |
| `PostgreSQL`  | `String`                      | `varchar`             | `Integer`                    | Alias for `character varying` |


**Argument types:**
- `expression` — `Array of fractional numbers | Array of integers | Array of strings | Date | Fractional number | Integer | String`
- `native_type` — `String`
- `param_1` — `Any`
- `param_2` — `Any`


**Return type**: Same type as (`expression`)

{% note info %}

Only constant values are accepted for the arguments (`native_type`).

{% endnote %}


#### Examples {#examples}

```
DB_CAST([float_value], "Decimal", 10, 5)
```

```
DB_CAST([float_value], "double precision")
```

```
DB_CAST([float_value], "numeric", 10, 5)
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `PostgreSQL 9.3`, `Yandex Documents`.
