---
editable: false
---

# SUM_IF

_Aggregate functions_

#### Syntax


```
SUM_IF( expression, condition )
```

#### Description
Returns the sum of all the expression values that meet the `condition` condition. Applicable to numeric data types only.

**Argument types:**
- `expression` — `Number`
- `condition` — `Boolean`


**Return type**: Same type as (`expression`)

#### Examples

```
SUM_IF([Profit], [Profit] > 15)
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`
