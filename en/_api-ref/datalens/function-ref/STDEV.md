---
editable: false
---

# STDEV

_Aggregate functions_

#### Syntax


```
STDEV( value )
```

#### Description
Returns the statistical standard deviation of all values in the expression based on a selection from the population.

**Argument types:**
- `value` — `Number`


**Return type**: `Number (decimal)`

#### Examples

```
STDEV([Profit])
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
