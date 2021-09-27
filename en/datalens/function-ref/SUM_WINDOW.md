---
editable: false
---

# SUM (window)

_Function `SUM` is also available as an [aggregate function](SUM.md)._

#### Syntax {#syntax}


```
SUM( value [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )
```

#### Description {#description}
Returns the sum of all expression values. Applicable to numeric data types only.

**Argument types:**
- `value` — `Fractional number | Integer`


**Return type**: Same type as (`value`)

#### Examples {#examples}

```
SUM([Profit] TOTAL)
```

```
SUM([Profit] WITHIN [Date])
```

```
SUM([Profit] AMONG [Date])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
