---
editable: false
---

# AVG (window)

_Function `AVG` is also available as an [aggregate function](AVG.md)._

#### Syntax {#syntax}


```
AVG( value [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )
```

#### Description {#description}
Returns the average of all values. Applicable to numeric data types.

**Argument types:**
- `value` — `Any`


**Return type**: `Fractional number`

#### Examples {#examples}

```
AVG([Profit] TOTAL)
```

```
AVG([Profit] WITHIN [Date])
```

```
AVG([Profit] AMONG [Date])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
