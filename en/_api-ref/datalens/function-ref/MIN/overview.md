---
editable: false
---

# MIN

_Aggregate functions_

#### Syntax


```
MIN( value )
```

#### Description
Returns the minimum value.

If `value`:
- number — Returns the smallest number.
- date — Returns the earliest date.
- string — Returns the first value in the alphabetic order.


**Argument types:**
- `value` — `Any`


**Return type**: Same type as (`value`)

#### Examples

```
MIN([Profit])
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`
