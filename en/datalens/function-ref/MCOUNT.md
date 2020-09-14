---
editable: false
---

# MCOUNT

_Window functions_

#### Syntax {#syntax}


```
MCOUNT( value, rows_1 [ , rows_2 ] [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )
```

#### Description {#description}
Returns the moving count of (non-`NULL`) values in a fixed-size window defined by the sort order and arguments:

| `rows_1`   | `rows_2`   | Window                                                                |
|:-----------|:-----------|:----------------------------------------------------------------------|
| positive   | -          | The current row and `rows_1` preceding rows.                          |
| negative   | -          | The current row and -`rows_1` following rows.                         |
| any sign   | any sign   | `rows_1` preceding rows, the current row and `rows_2` following rows. |


Window functions with a similar behavior: [MSUM](MSUM.md), [MMIN](MMIN.md), [MMAX](MMAX.md), [MAVG](MAVG.md).

See also [COUNT](COUNT.md), [RCOUNT](RCOUNT.md).

**Argument types:**
- `value` — `Any`
- `rows_1` — `Number (whole)`
- `rows_2` — `Number (whole)`


**Return type**: Same type as (`value`)

{% note info %}

Only constant values are accepted for arguments (`rows_1`, `rows_2`).

{% endnote %}

{% note warning %}

Function depends on how data is ordered in the chart. It will work correctly only if:
- data ordering is explicitly specified in the chart;
- result is ordered by __all__ fields that don't use window functions.

{% endnote %}


#### Examples {#examples}

```
MCOUNT([Profit], -2)
```

```
MCOUNT([Profit], 3)
```

```
MCOUNT([Profit] 5, 5 TOTAL)
```

```
MCOUNT([Profit], -5 WITHIN [Date])
```

```
MCOUNT([Profit], -5 AMONG [Date])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
