---
editable: false
---

# STDEVP

_Aggregate functions_

#### Syntax {#syntax}


```
STDEVP( value )
```

#### Description {#description}
Returns the statistical standard deviation of all values in the expression based on the biased population.

**Argument types:**
- `value` — `Number`


**Return type**: `Number (decimal)`

#### Examples {#examples}

```
STDEVP([Profit])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
