---
editable: false
---

# DATE

_Type conversion functions_

#### Syntax


```
DATE( expression [ , timezone ] )
```

#### Description
Converts the `expression` expression to date format.

The date must be in the format `YYYY-MM-DD`.

If `expression` is a number, then the `timezone` option can be used to convert the date to the specified time zone.

**Argument types:**
- `expression` — `Date | Datetime | Number | String`
- `timezone` — `String`


**Return type**: `Date`

{% note info %}

Only constant values are accepted for arguments (timezone).

{% endnote %}

{% note info %}

Argument `timezone` is available only for `Materialized Dataset`, `ClickHouse` sources.

{% endnote %}


#### Examples

```
DATE("2019-01-23") = #2019-01-23#
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`
