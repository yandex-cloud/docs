---
editable: false
---

# GREATEST



#### Syntax {#syntax}


```
GREATEST( value_1, value_2, value_3 [ , ... ] )
```

#### Description {#description}
Returns the greatest value.

See also [LEAST](LEAST.md).

Depending on the specified data type, it returns:
- The greatest number.
- The last string in alphabetical order.
- The latest date.
- `TRUE` when selecting between `TRUE` and `FALSE` for Boolean type.

**Argument types:**
- `value_1` — `Boolean | Date | Datetime | Number | String`
- `value_2` — `Boolean | Date | Datetime | Number | String`
- `value_3` — `Boolean | Date | Datetime | Number | String`


**Return type**: Same type as (`value_1`, `value_2`, `value_3`)

{% note info %}

Arguments (`value_1`, `value_2`, `value_3`) must be of the same type.

{% endnote %}


#### Examples {#examples}

```
GREATEST(3.4, 2.6) = 3.4
```

```
GREATEST("3.4", "2.6") = "3.4"
```

```
GREATEST(#2019-01-02#, #2019-01-17#) = #2019-01-17#
```

```
GREATEST(#2019-01-02 04:03:02#, #2019-01-17 03:02:01#) = #2019-01-17 03:02:01#
```

```
GREATEST(TRUE, FALSE) = TRUE
```

```
GREATEST(34, 5, 7, 3, 99, 1, 2, 2, 56) = 99
```

```
GREATEST(5.6, 1.2, 7.8, 3.4) = 7.8
```

```
GREATEST(#2019-01-02#, #2019-01-17#, #2019-01-10#) = #2019-01-17#
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
