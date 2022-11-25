---
editable: false
---

# DATE



#### Syntax {#syntax}


```
DATE( expression [ , timezone ] )
```

#### Description {#description}

{% note warning %}

For `ClickHouse` data sources, numeric `expression` values less than or equal to `65535` are interpreted as the number of days (not seconds, like in all other cases) since January 1st 1970. This is the result of the behavior of available `ClickHouse` functions.

One way to surpass this is to use the following formula: `DATE(DATETIME([value]))`. The result is more consistent, but is likely to be much slower.

{% endnote %}

Converts the `expression` expression to date format.

The date must be in the format `YYYY-MM-DD`.

If `expression` is a number, then the `timezone` option can be used to convert the date to the specified time zone.

**Argument types:**
- `expression` — `Date | Datetime | Fractional number | Integer | String`
- `timezone` — `String`


**Return type**: `Date`

{% note info %}

Only constant values are accepted for the arguments (`timezone`).

{% endnote %}

{% note info %}

Argument `timezone` is available only for `ClickHouse` sources.

{% endnote %}


#### Example {#examples}

```
DATE("2019-01-23") = #2019-01-23#
```


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
