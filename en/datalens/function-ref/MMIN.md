---
editable: false

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# MMIN (window)



#### Syntax {#syntax}


```
MMIN( value, rows_1 [ , rows_2 ] [ TOTAL | WITHIN ... | AMONG ... ] [ ORDER BY ... ] [ BEFORE FILTER BY ... ] )
```

#### Description {#description}

{% note warning %}

The sorting order is based on the fields listed in the sorting section of the chart and in the `ORDER BY` clause. First, `ORDER BY` fields are used, and then they are complemented by the fields from the chart.

{% endnote %}

Returns the moving minimum of values in a fixed-size window defined by the sort order and arguments:

| `rows_1`   | `rows_2`   | Window                                                                |
|:-----------|:-----------|:----------------------------------------------------------------------|
| positive   | -          | The current row and `rows_1` preceding rows.                          |
| negative   | -          | The current row and -`rows_1` following rows.                         |
| any sign   | any sign   | `rows_1` preceding rows, the current row and `rows_2` following rows. |


Window functions with a similar behavior: [MSUM](MSUM.md), [MCOUNT](MCOUNT.md), [MMAX](MMAX.md), [MAVG](MAVG.md).

See also [MIN](MIN.md), [RMIN](RMIN.md).

**Argument types:**
- `value` — `Boolean | Date | Datetime | Fractional number | Integer | String | UUID`
- `rows_1` — `Integer`
- `rows_2` — `Integer`


**Return type**: Same type as (`value`)

{% note info %}

Only constant values are accepted for arguments (`rows_1`, `rows_2`).

{% endnote %}


#### Examples {#examples}

```
MMIN([Profit], -2)
```

```
MMIN([Profit], 3)
```

```
MMIN([Profit] 5, 5 TOTAL)
```

```
MMIN([Profit], -5 WITHIN [Date])
```

```
MMIN([Profit], -5 AMONG [Date])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
