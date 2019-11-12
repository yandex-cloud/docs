---
editable: false
---

# AVG_IF

_Aggregate functions_

#### Syntax


```
AVG_IF( expression, condition )
```

#### Description
Returns the average of all values that meet the `condition` condition. If the values don't exist, it returns `NULL`. Applicable to numeric data types only.

**Argument types:**
- `expression` — `Number`
- `condition` — `Boolean`


**Return type**: `Number (decimal)`

#### Examples

```
AVG([Profit], [Profit] > 5)
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`
