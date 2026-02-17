---
editable: false
---

# DB_CALL_BOOL



#### Syntax {#syntax}


```
DB_CALL_BOOL( db_function_name [ , arg_1 [ , arg_2 [ , ... ] ] ] )
```

#### Description {#description}

{% note warning %}

The availability and behavior of native functions depends on your database type and version.

It is recommended to use native functions only if there is no supported {{ datalens-short-name }} function (composition of functions) that can achieve the required result.

{% endnote %}

Calls a native database function by its name. Native function should return a value of type `Boolean`. The function is executed for every row in the dataset (non-aggregated).

The first argument `db_function_name` must be a constant string with the name of the database function to call. All subsequent arguments are passed to the native function in the same order as written in the formula and can be of any type, including types that are not currently supported by {{ datalens-short-name }}.

The function name must contain only alphanumeric characters, underscore and colon characters.

**Argument types:**
- `db_function_name` — `String`
- `arg_1` — `Any`
- `arg_2` — `Any`


**Return type**: `Boolean`

{% note info %}

Only constant values are accepted for the arguments (`db_function_name`).

{% endnote %}


#### Examples {#examples}

```
DB_CALL_BOOL("isFinite", 5) = TRUE -- ClickHouse: check if 5 is a finite number
```

```
DB_CALL_BOOL("isInfinite", 5) = FALSE -- ClickHouse: check if 5 is an infinite number
```

```
DB_CALL_BOOL("bitTest", [int_field], 4) -- ClickHouse: check if the 4th bit equals 1, useful when multiple values are encoded in one field
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Trino`, `YDB`.
