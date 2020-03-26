---
editable: false
---

# COUNTD_IF

_Aggregate functions_

#### Syntax


```
COUNTD_IF( expression, condition )
```

#### Description
Returns the number of unique values in the group that meet the `condition` condition.

See also [COUNTD_APPROX](../COUNTD_APPROX/overview.md).

**Argument types:**
- `expression` — `Any`
- `condition` — `Boolean`


**Return type**: `Number (whole)`

#### Examples

```
COUNTD_IF([ClientID], [Profit] > 5)
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
