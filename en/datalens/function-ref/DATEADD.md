---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/DATEADD.md
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
- `"year"`;
- `"month"`;
- `"day"`;
- `"hour"`;
- `"minute"`;
- `"second"`.

**Argument types:**
- `datetime` — `Date | Datetime`
- `unit` — `Integer | String`
- `number` — `Integer`


**Return type**: Same type as (`datetime`)

{% note info %}

Only constant values are accepted for the arguments (`unit`).

{% endnote %}

{% note info %}

For all sources except `ClickHouse`, `number` takes only constant values.

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

`ClickHouse 21.8`, `Yandex Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
