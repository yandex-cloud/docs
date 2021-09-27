---
editable: false
---

# DATE



#### Syntax {#syntax}


```
DATE( expression [ , timezone ] )
```

#### Description {#description}
Converts the `expression` expression to date format.

The date must be in the format `YYYY-MM-DD`.

If `expression` is a number, then the `timezone` option can be used to convert the date to the specified time zone.

**Argument types:**
- `expression` — `Date | Datetime | Fractional number | Integer | String`
- `timezone` — `String`


**Return type**: `Date`

{% note info %}

Only constant values are accepted for arguments (`timezone`).

{% endnote %}

{% note info %}

Argument `timezone` is available only for `Materialized Dataset`, `ClickHouse` sources.

{% endnote %}


#### Examples {#examples}

```
DATE("2019-01-23") = #2019-01-23#
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
