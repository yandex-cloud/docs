---
editable: false
---

# AVG

_Aggregate functions_

#### Syntax


```
AVG( value )
```

#### Description
Returns the average of all values. Applicable to numeric data types as well as `Date | Datetime`.

**Argument types:**
- `value` — `Date | Datetime | Number`


**Return type**: Depends on argument types

#### Examples

```
AVG([Profit])
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
