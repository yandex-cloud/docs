---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/SUM_IF_WINDOW.md
---


# SUM_IF (window)

_Function `SUM_IF` is also available as an [aggregate function](SUM_IF.md)._

#### Syntax {#syntax}


```
SUM_IF( expression, condition [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )
```

#### Description {#description}
Returns the sum of all the expression values that meet the `condition` condition. Applicable to numeric data types only.

**Argument types:**
- `expression` — `Fractional number | Integer`
- `condition` — `Boolean`


**Return type**: Same type as (`expression`)

#### Examples {#examples}

```
SUM_IF([Profit], [Category] = 'Office Supplies' TOTAL)
```

```
SUM_IF([Profit], [Category] = 'Office Supplies' WITHIN [Date])
```

```
SUM_IF([Profit], [Category] = 'Office Supplies' AMONG [Date])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
