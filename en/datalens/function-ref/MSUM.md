---
editable: false
---

# MSUM

_Window functions_

#### Syntax {#syntax}


```
MSUM( value, rows_1 [ , rows_2 ] [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] [ ORDER BY ... ] )
```

#### Description {#description}
Returns the moving sum of values in a fixed-size window defined by the sort order and arguments:

| `rows_1`   | `rows_2`   | Window                                                                |
|:-----------|:-----------|:----------------------------------------------------------------------|
| positive   | -          | The current row and `rows_1` preceding rows.                          |
| negative   | -          | The current row and -`rows_1` following rows.                         |
| any sign   | any sign   | `rows_1` preceding rows, the current row and `rows_2` following rows. |


Window functions with a similar behavior: [MCOUNT](MCOUNT.md), [MMIN](MMIN.md), [MMAX](MMAX.md), [MAVG](MAVG.md).

See also [SUM](SUM.md), [RSUM](RSUM.md).

**Argument types:**
- `value` — `Number`
- `rows_1` — `Number (whole)`
- `rows_2` — `Number (whole)`


**Return type**: Same type as (`value`)

{% note info %}

Only constant values are accepted for arguments (`rows_1`, `rows_2`).

{% endnote %}

{% note warning %}

The sorting order is based on the fields listed in the chart's sorting section and in the function's `ORDER BY` clause. First, `ORDER BY` fields are used, and then they are complemented by the fields from the chart.


{% endnote %}


#### Examples {#examples}

```
MSUM([Profit], -2)
```

```
MSUM([Profit], 3)
```

```
MSUM([Profit] 5, 5 TOTAL)
```

```
MSUM([Profit], -5 WITHIN [Date])
```

```
MSUM([Profit], -5 AMONG [Date])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
