---
editable: false
---

# INT



#### Syntax {#syntax}


```
INT( expression )
```

#### Description {#description}
Converts the `expression` expression to integer format according to the following rules:

| Type                                                           | Value                                                                                                                                                                                                             |
|:---------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `Integer`                                                      | Original value.                                                                                                                                                                                                   |
| `Fractional number`                                            | Integer part of the number (rounded down).                                                                                                                                                                        |
| <code>Date &#124; Datetime &#124; Datetime (deprecated)</code> | [Unix time](https://en.wikipedia.org/wiki/Unix_time) corresponding to the date and time. If the value contains time zone data, it's used in the calculation. If the time zone is unknown, the time is set in UTC. |
| `String`                                                       | A number from a decimal string.                                                                                                                                                                                   |
| `Boolean`                                                      | `TRUE` — `1`, `FALSE` — `0`.                                                                                                                                                                                      |

**Argument types:**
- `expression` — `Boolean | Date | Datetime | Datetime (deprecated) | Fractional number | Integer | String`


**Return type**: `Integer`

#### Examples {#examples}

```
INT(7.7) = 7
```

```
INT("365") = 365
```

```
INT(TRUE) = 1
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
