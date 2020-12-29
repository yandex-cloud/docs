---
editable: false
---

# DB_CAST



#### Syntax {#syntax}


```
DB_CAST( expression, native_type [ , param_1 [ , param_2 ] ] )
```

#### Description {#description}
Converts the `expression` expression to database's native type `native_type`.

The following type casts are supported:

| Data source   | Data type          | Native data type    | Parameters for native type         | Comment                       |
|:--------------|:-------------------|:--------------------|:-----------------------------------|:------------------------------|
| `ClickHouse`  | `Number (decimal)` | `Float32`           |                                    |                               |
| `ClickHouse`  | `Number (decimal)` | `Float64`           |                                    |                               |
| `ClickHouse`  | `Number (decimal)` | `Decimal`           | `Number (whole)`, `Number (whole)` |                               |
| `ClickHouse`  | `Number (whole)`   | `Int8`              |                                    |                               |
| `ClickHouse`  | `Number (whole)`   | `Int16`             |                                    |                               |
| `ClickHouse`  | `Number (whole)`   | `Int32`             |                                    |                               |
| `ClickHouse`  | `Number (whole)`   | `Int64`             |                                    |                               |
| `ClickHouse`  | `String`           | `String`            |                                    |                               |
| `PostgreSQL`  | `Number (decimal)` | `double precision`  |                                    |                               |
| `PostgreSQL`  | `Number (decimal)` | `real`              |                                    |                               |
| `PostgreSQL`  | `Number (decimal)` | `numeric`           | `Number (whole)`, `Number (whole)` |                               |
| `PostgreSQL`  | `Number (whole)`   | `smallint`          |                                    |                               |
| `PostgreSQL`  | `Number (whole)`   | `integer`           |                                    |                               |
| `PostgreSQL`  | `Number (whole)`   | `bigint`            |                                    |                               |
| `PostgreSQL`  | `String`           | `text`              |                                    |                               |
| `PostgreSQL`  | `String`           | `character`         | `Number (whole)`                   | Alias: `char`                 |
| `PostgreSQL`  | `String`           | `character varying` | `Number (whole)`                   | Alias: `varchar`              |
| `PostgreSQL`  | `String`           | `char`              | `Number (whole)`                   | Alias for `character`         |
| `PostgreSQL`  | `String`           | `varchar`           | `Number (whole)`                   | Alias for `character varying` |


**Argument types:**
- `expression` — `Number | String`
- `native_type` — `String`
- `param_1` — `Any`
- `param_2` — `Any`


**Return type**: Same type as (`expression`)

{% note info %}

Only constant values are accepted for arguments (`native_type`).

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

`Materialized Dataset`, `ClickHouse 1.1`, `PostgreSQL 9.3`.
