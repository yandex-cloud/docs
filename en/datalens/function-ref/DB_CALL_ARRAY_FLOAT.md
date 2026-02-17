---
editable: false
---

# DB_CALL_ARRAY_FLOAT



#### Syntax {#syntax}


```
DB_CALL_ARRAY_FLOAT( db_function_name [ , arg_1 [ , arg_2 [ , ... ] ] ] )
```

#### Description {#description}

{% note warning %}

The availability and behavior of native functions depends on your database type and version.

It is recommended to use native functions only if there is no supported {{ datalens-short-name }} function (composition of functions) that can achieve the required result.

{% endnote %}

Calls a native database function by its name. Native function should return a value of type `Array of fractional numbers`. The function is executed for every row in the dataset (non-aggregated).

The first argument `db_function_name` must be a constant string with the name of the database function to call. All subsequent arguments are passed to the native function in the same order as written in the formula and can be of any type, including types that are not currently supported by {{ datalens-short-name }}.

The function name must contain only alphanumeric characters, underscore and colon characters.

**Argument types:**
- `db_function_name` — `String`
- `arg_1` — `Any`
- `arg_2` — `Any`


**Return type**: `Array of fractional numbers`

{% note info %}

Only constant values are accepted for the arguments (`db_function_name`).

{% endnote %}


#### Examples {#examples}

```
DB_CALL_ARRAY_FLOAT("arrayConcat", ARRAY(1.0, 2.0), ARRAY(3.0)) = ARRAY(1.0, 2.0, 3.0) -- ClickHouse: concatenate arrays of floats
```

```
DB_CALL_ARRAY_FLOAT("arrayCompact", [float_arr_field]) -- ClickHouse: remove duplicate consecutive values from array of floats
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Trino`, `YDB`.
