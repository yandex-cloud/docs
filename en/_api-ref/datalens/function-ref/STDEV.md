---
editable: false
---

# STDEV

_Aggregate functions_

#### Syntax {#syntax}


```
STDEV( value )
```

#### Description {#description}
Returns the statistical standard deviation of all values in the expression based on a selection from the population.

**Argument types:**
- `value` — `Number`


**Return type**: `Number (decimal)`

#### Examples {#examples}

```
STDEV([Profit])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
