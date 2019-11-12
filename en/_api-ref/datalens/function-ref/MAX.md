---
editable: false
---

# MAX

_Aggregate functions_

#### Syntax


```
MAX( value )
```

#### Description
Returns the maximum value.

If `value`:
- number — Returns the largest number.
- date — Returns the latest date.
- string — Returns the last value in the alphabetic order.


**Argument types:**
- `value` — `Any`


**Return type**: Same type as (`value`)

#### Examples

```
MAX([Profit])
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`
