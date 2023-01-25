---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/AGO.md
---

# AGO



#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  AGO( measure, date_dimension [ , unit [ , number ] ] )
  ```

- Extended

  ```
  AGO( measure, date_dimension [ , unit [ , number ] ]
       [ BEFORE FILTER BY ... ]
       [ IGNORE DIMENSIONS ... ]
     )
  ```

  More info:
  - [BEFORE FILTER BY](time-series-functions.md#syntax-before-filter-by)
  - [IGNORE DIMENSIONS](time-series-functions.md#syntax-ignore-dimensions)

{% endlist %}

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

See also [AT_DATE](AT_DATE.md), [LAG](LAG.md).

**Argument types:**
- `measure` — `Any`
- `date_dimension` — `Date | Datetime`
- `unit` — `Integer | String`
- `number` — `Integer`


**Return type**: Same type as (`measure`)

{% note info %}

Only constant values are accepted for the arguments (`unit`, `number`).

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

`ClickHouse 19.13`, `Yandex Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
