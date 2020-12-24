---
editable: false
---

# DATEADD



#### Syntax {#syntax}


```
DATEADD( datetime [ , unit [ , number ] ] )
```

#### Description {#description}
Returns the date obtained by adding `unit` in the amount of `number` to the specified date `datetime`.

The `number` argument is an integer. It can be negative.
The `unit` argument takes the following values:
- `"year"`,
- `"month"`,
- `"day"`,
- `"hour"`,
- `"minute"`,
- `"second"`.

**Argument types:**
- `datetime` — `Date | Datetime`
- `unit` — `Number (whole) | String`
- `number` — `Number (whole)`


**Return type**: Same type as (`datetime`)

{% note info %}

Only constant values are accepted for arguments (`unit`).

{% endnote %}

{% note info %}

For all sources except `Materialized Dataset`, `ClickHouse`, `number` takes only constant values.

{% endnote %}


#### Examples {#examples}

```
DATEADD(#2018-01-12#, "day", 6) = #2018-01-18#
```

```
DATEADD(#2018-01-12#, "month", 6) = #2018-07-12#
```

```
DATEADD(#2018-01-12#, "year", 6) = #2024-01-12#
```

```
DATEADD(#2018-01-12 01:02:03#, "second", 6) = #2018-01-12 01:02:09#
```

```
DATEADD(#2018-01-12 01:02:03#, "minute", 6) = #2018-01-12 01:08:03#
```

```
DATEADD(#2018-01-12 01:02:03#, "hour", 6) = #2018-01-12 07:02:03#
```

```
DATEADD(#2018-01-12 01:02:03#, "day", 6) = #2018-01-18 01:02:03#
```

```
DATEADD(#2018-01-12 01:02:03#, "month", 6) = #2018-07-12 01:02:03#
```

```
DATEADD(#2018-01-12 01:02:03#, "year", 6) = #2024-01-12 01:02:03#
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Yandex.Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
