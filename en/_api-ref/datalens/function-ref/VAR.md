---
editable: false
---

# VAR

_Aggregate functions_

#### Syntax


```
VAR( value )
```

#### Description
Returns the statistical variance of all values in an expression based on a selection from the population.

**Argument types:**
- `value` — `Number`


**Return type**: `Number (decimal)`

#### Examples

```
VAR([Profit])
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
