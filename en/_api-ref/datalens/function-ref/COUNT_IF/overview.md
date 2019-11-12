---
editable: false
---

# COUNT_IF

_Aggregate functions_

#### Syntax


```
COUNT_IF( condition )
```

#### Description
Returns the number of items in the group meeting the `condition` condition.

**Argument types:**
- `condition` — `Boolean`


**Return type**: `Number (whole)`

#### Examples

```
COUNT_IF([Profit] > 5)
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`
