---
editable: false
---

# Addition and concatenation (+)



#### Syntax {#syntax}


```
value_1 + value_2
```

#### Description {#description}
Behaves differently depending on the argument types. Possible options are listed in the table:

| Type of `value_1`   | Type of `value_2`   | Return value                                                                                                                                                                     |
|:--------------------|:--------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `Number`            | `Number`            | The sum of the numbers `value_1` and `value_2`.                                                                                                                                  |
| `Date`              | `Number`            | The date that is `value_2` days greater than `value_1` (rounded down to an integer number of days).                                                                              |
| `Datetime`          | `Number`            | The date with time, `value_2` days greater than `value_1`. If `value_2` contains a fractional part, it is converted hours (`1/24`), minutes (`1/1440`), and seconds (`1/86400`). |
| `String`            | `String`            | The merging (concatenation) of strings `value_1` and `value_2`.                                                                                                                  |

Changing the order of arguments does not affect the result.

**Argument types:**
- `value_1` — `Date | Datetime | Markup | Number | String`
- `value_2` — `Date | Datetime | Markup | Number | String`


**Return type**: Depends on argument types

#### Examples {#examples}

```
2 + 3 = 5
```

```
"Lorem" + " ipsum" = "Lorem ipsum"
```

```
#2019-01-06# + 2 = #2019-01-08#
```

```
2.2 + #2019-01-06# = #2019-01-08#
```

```
2 + #2019-01-06 03# = #2019-01-08 03:00:00#
```

```
#2019-01-06 03# + 2.5 = #2019-01-08 15:00:00#
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Yandex.Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
