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

**Argument types:**
- `datetime` — `Date | Datetime | Datetime (deprecated)`
- `unit` — `String`
- `number` — `Integer`


**Return type**: Same type as (`datetime`)

{% note info %}

Only constant values are accepted for the arguments (`unit`, `number`).

{% endnote %}

{% note info %}

The function with three arguments is only available for the sources `Materialized Dataset`, `ClickHouse` version `19.13` or higher.

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

```
DATETRUNC(#2018-07-12 11:07:13#, "month", 4) = #2018-05-01 00:00:00#
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
