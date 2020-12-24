---
editable: false
---

# Subtraction (-)



#### Syntax {#syntax}


```
value_1 - value_2
```

#### Description {#description}
Behaves differently depending on the argument types. Possible options are listed in the table:

| Type of `value_1`   | Type of `value_2`   | Return value                                                                                                                                                                                                       |
|:--------------------|:--------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `Number`            | `Number`            | The difference between the numbers `value_1` and `value_2`.                                                                                                                                                        |
| `Date`              | `Number`            | The date that is `value_2` days smaller than `value_1` (rounded down to an integer number of days).                                                                                                                |
| `Datetime`          | `Number`            | The date with time, `value_2` days smaller than `value_1`. If `value_2` contains a fractional part, it is converted to hours (`1/24`), minutes (`1/1440`), and seconds (`1/86400`).                                |
| `Date`              | `Date`              | The difference between two dates in days.                                                                                                                                                                          |
| `Datetime`          | `Datetime`          | The difference between two dates in days: the integer part — the number of whole days, the fractional part — the number of hours, minutes and seconds expressed as a fraction of the whole day (1 hour is '1/24'). |

**Argument types:**
- `value_1` — `Date | Datetime | Number`
- `value_2` — `Date | Datetime | Number`


**Return type**: Depends on argument types

#### Examples {#examples}

```
2 - 3 = -1
```

```
2 - 0.5 = 1.5
```

```
#2019-01-06# - 2 = #2019-01-04#
```

```
#2019-01-06# - 2.2 = #2019-01-03#
```

```
#2019-01-06 03:00:00# - 2 = #2019-01-04 03:00:00#
```

```
#2019-01-06 03:00:00# - 2.5 = #2019-01-03 15:00:00#
```

```
#2019-01-06# - #2019-01-02# = 4
```

```
#2019-01-06 15:00:00# - #2019-01-02 03:00:00# = 4.5
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Yandex.Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
