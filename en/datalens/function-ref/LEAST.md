---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/LEAST.md
---

# LEAST



#### Syntax {#syntax}


```
LEAST( value_1, value_2, value_3 [ , ... ] )
```

#### Description {#description}
Returns the smallest value.

See also [GREATEST](GREATEST.md).

Depending on the specified data type, it returns:
- The smallest number.
- The first string in alphabetical order.
- The earliest date.
- `FALSE` when selecting between `TRUE` and `FALSE` for Boolean type.

**Argument types:**
- `value_1` — `Boolean | Date | Datetime | Fractional number | Integer | String`
- `value_2` — `Boolean | Date | Datetime | Fractional number | Integer | String`
- `value_3` — `Boolean | Date | Datetime | Fractional number | Integer | String`


**Return type**: Same type as (`value_1`, `value_2`, `value_3`)

{% note info %}

Arguments (`value_1`, `value_2`, `value_3`) must be of the same type.

{% endnote %}


#### Examples {#examples}

```
LEAST(3.4, 2.6) = 2.6
```

```
LEAST("3.4", "2.6") = "2.6"
```

```
LEAST(#2019-01-02#, #2019-01-17#) = #2019-01-02#
```

```
LEAST(#2019-01-02 04:03:02#, #2019-01-17 03:02:01#) = #2019-01-02 04:03:02#
```

```
LEAST(TRUE, FALSE) = FALSE
```

```
LEAST(34, 5, 7, 3, 99, 1, 2, 2, 56) = 1
```

```
LEAST(5.6, 1.2, 7.8, 3.4) = 1.2
```

```
LEAST(#2019-01-02#, #2019-01-17#, #2019-01-10#) = #2019-01-02#
```


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
