---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/DATETRUNC.md
---

# DATETRUNC



#### Syntax {#syntax}


```
DATETRUNC( datetime, unit [ , number ] )
```

#### Description {#description}
Rounds `datetime` down to the given `unit`. If optional `number` is given, then the value is rounded down to a `number` multiple of `unit` (omitting `number` is the same as `number = 1`).

Supported units:
- `"second"`;
- `"minute"`;
- `"hour"`;
- `"day"` (acts as the day of the year if `number` is specified);
- `"week"`;
- `"month"`;
- `"quarter"`;
- `"year"`.

When using a function with three arguments, it is processed on the {{ CH }} side by the [toStartOfInterval function](https://clickhouse.com/docs/en/sql-reference/functions/date-time-functions#tostartofinterval). Rounding is done relative to a specific point in time, as detailed in the table in the function description. For example:
```
DATETRUNC(#2018-07-12 11:07:13#, "month", 4) = #2018-05-01 00:00:00#
```

For the `unit` argument set to `month`, rounding starts from `1900-01-01`. There are 1,422 months between `2018-07-12` and `1900-01-01`. Rounding this value to the nearest number divisible by 4 (the `number` argument), we get 1,420 months. Thus, adding 1,420 months to `1900-01-01` gives us `2018-05-01`.

**Argument types:**
- `datetime` — `Date | Datetime`
- `unit` — `String`
- `number` — `Integer`


**Return type**: Same type as (`datetime`)

{% note info %}

Only constant values are accepted for the arguments (`unit`, `number`).

{% endnote %}

{% note info %}

The function with three arguments is only available for the sources `ClickHouse` version `21.8` or higher.

{% endnote %}


#### Examples {#examples}

```
DATETRUNC(#2018-07-12 11:07:13#, "minute") = #2018-07-12 11:07:00#
```

```
DATETRUNC(#2018-07-12#, "year", 5) = #2015-01-01#
```

```
DATETRUNC(#2018-07-12 11:07:13#, "second", 5) = #2018-07-12 11:07:10#
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Yandex Documents`, `YDB`.
