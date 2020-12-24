---
editable: false
---

# AVG_IF (window)

_Function `AVG_IF` is also available as an [aggregate function](AVG_IF.md)._

#### Syntax {#syntax}


```
AVG_IF( expression, condition [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )
```

#### Description {#description}
Returns the average of all values that meet the `condition` condition. If the values don't exist, it returns `NULL`. Applicable to numeric data types only.

**Argument types:**
- `expression` — `Number`
- `condition` — `Boolean`


**Return type**: Same type as (`expression`)

#### Examples {#examples}

```
AVG_IF([Profit], [Category] = 'Office Supplies' TOTAL)
```

```
AVG_IF([Profit], [Category] = 'Office Supplies' WITHIN [Date])
```

```
AVG_IF([Profit], [Category] = 'Office Supplies' AMONG [Date])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
