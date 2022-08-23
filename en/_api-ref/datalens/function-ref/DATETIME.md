---
editable: false
---

# DATETIME



#### Syntax {#syntax}


```
DATETIME( expression [ , timezone ] )
```

#### Description {#description}
Converts the `expression` expression to date and time format. When converting `Date` to `DateTime`, the time is set to '00:00:00'.
The date must be in the format `YYYY-MM-DDThh:mm:ss` or `YYYY-MM-DD hh:mm:ss`.

If `expression` is a number, then the date and time can be converted to the specified time zone when the `timezone` option is available.

**Argument types:**
- `expression` — `Date | Datetime | Datetime (deprecated) | Fractional number | Integer | String`
- `timezone` — `String`


**Return type**: `Datetime (deprecated)`

{% note info %}

Only constant values are accepted for the arguments (`timezone`).

{% endnote %}

{% note info %}

Argument `timezone` is available only for `Materialized Dataset`, `ClickHouse` sources.

{% endnote %}


#### Example {#examples}

```
DATETIME("2019-01-23 15:07:47") = #2019-01-23 15:07:47#
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
