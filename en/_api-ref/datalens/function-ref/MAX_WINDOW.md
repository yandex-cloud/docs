---
editable: false
---

# MAX (window)

_Function `MAX` is also available as an [aggregate function](MAX.md)._

#### Syntax {#syntax}


```
MAX( value [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )
```

#### Description {#description}
Returns the maximum value.

If `value`:
- number — Returns the largest number.
- date — Returns the latest date.
- string — Returns the last value in the alphabetic order.


**Argument types:**
- `value` — `Boolean | Date | Datetime | Fractional number | Integer | String | UUID`


**Return type**: Same type as (`value`)

#### Examples {#examples}

```
MAX([Profit] TOTAL)
```

```
MAX([Profit] WITHIN [Date])
```

```
MAX([Profit] AMONG [Date])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
