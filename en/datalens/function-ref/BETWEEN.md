---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/BETWEEN.md
---

# BETWEEN



#### Syntax {#syntax}


```
value [ NOT ] BETWEEN low AND high
```

#### Description {#description}
Returns `TRUE` if `value` is in the range from `low` to `high` inclusive.

The option `value NOT BETWEEN low AND high` returns the opposite value.

**Argument types:**
- `value` — `Date | Datetime | Fractional number | Integer | String`
- `low` — `Date | Datetime | Fractional number | Integer | String`
- `high` — `Date | Datetime | Fractional number | Integer | String`


**Return type**: `Boolean`

{% note info %}

Arguments `value`, `low`, `high` must be of the same type.

{% endnote %}


#### Examples {#examples}

```
3 BETWEEN 1 AND 100 = TRUE
```

```
100 BETWEEN 1 AND 100 = TRUE
```

```
3 NOT BETWEEN 1 AND 100 = FALSE
```

```
#2018-01-12# BETWEEN #2018-01-10# AND #2018-01-15# = TRUE
```

```
#2018-01-12 01:02:10# BETWEEN #2018-01-12 01:02:00# AND #2018-01-12 01:02:30# = TRUE
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Yandex Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
