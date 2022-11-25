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
Returns `TRUE` if `value` is in the range from `low` to `high`.

The option `value NOT BETWEEN low AND high` returns the opposite value.

**Argument types:**
- `value` — `Date | Datetime | Fractional number | Integer | String`
- `low` — `Date | Datetime | Fractional number | Integer | String`
- `high` — `Date | Datetime | Fractional number | Integer | String`


**Return type**: `Boolean`

#### Examples {#examples}

```
3 BETWEEN 1 AND 100 = TRUE
```

```
3 NOT BETWEEN 1 AND 100 = FALSE
```


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Yandex.Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
