---
editable: false
---

# DB_CALL_STRING



#### Syntax {#syntax}


```
DB_CALL_STRING( db_function_name [ , arg_1 [ , arg_2 [ , ... ] ] ] )
```

#### Description {#description}

{% note warning %}

The availability and behavior of native functions depends on your database type and version.

It is recommended to use native functions only if there is no supported {{ datalens-short-name }} function (composition of functions) that can achieve the required result.

{% endnote %}

Calls a native database function by its name. Native function should return a value of type `String`. The function is executed for every row in the dataset (non-aggregated).

The first argument `db_function_name` must be a constant string with the name of the database function to call. All subsequent arguments are passed to the native function in the same order as written in the formula and can be of any type, including types that are not currently supported by {{ datalens-short-name }}.

The function name must contain only alphanumeric characters, underscore and colon characters.

**Argument types:**
- `db_function_name` — `String`
- `arg_1` — `Any`
- `arg_2` — `Any`


**Return type**: `String`

{% note info %}

Only constant values are accepted for the arguments (`db_function_name`).

{% endnote %}


#### Examples {#examples}

```
DB_CALL_STRING("dictGetStringOrDefault", "categories", "category_name", [category_id], "other") -- ClickHouse: read from dictionary with default value
```

```
DB_CALL_STRING("JSONExtractString", [json_field], "category", "last_order_date") -- ClickHouse: extract nested JSON attribute
```

```
DB_CALL_STRING("hex", DB_CALL_STRING("SHA1", [salt_param] + [some_id])) -- ClickHouse: calculate hash with salt
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Trino`, `YDB`.
