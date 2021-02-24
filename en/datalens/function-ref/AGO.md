---
editable: false
---

# AGO



#### Syntax {#syntax}


```
AGO( measure, date_dimension [ , unit [ , number ] ] )
```

#### Description {#description}
Re-evaluate `measure` for a date/time with a given offset.
The `date_dimension` argument is the dimension along which the offset is made.
The `number` argument is an integer. It can be negative.
The `unit` argument takes the following values:
- `"year"`;
- `"month"`;
- `"day"`;
- `"hour"`;
- `"minute"`;
- `"second"`.

Can also be used as `AGO( measure, date_dimension, number )`. In this case, the third argument is interpreted as the number of days.

This non-window function does not support window options such as `BEFORE FILTER BY`.

See also [AT_DATE](AT_DATE.md), [LAG](LAG.md).

**Argument types:**
- `measure` — `Any`
- `date_dimension` — `Date | Datetime`
- `unit` — `Number (whole) | String`
- `number` — `Number (whole)`


**Return type**: Same type as (`measure`)

{% note info %}

Only constant values are accepted for arguments (`unit`, `number`).

{% endnote %}

{% note info %}

The first argument must be a measure (aggregated expression), otherwise an error will be raised.

{% endnote %}


#### Examples {#examples}

```
AGO(SUM([Sales]), [Order Date], "month", 3)
```

```
AGO(SUM([Sales]), [Order Date], "year")
```

```
AGO(SUM([Sales]), [Order Date], 1)
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
