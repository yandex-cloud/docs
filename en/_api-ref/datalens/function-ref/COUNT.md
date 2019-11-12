---
editable: false
---

# COUNT

_Aggregate functions_

#### Syntax


```
COUNT(  [ value ] )
```

#### Description
Returns the number of items in the group.

**Argument types:**
- `value` — `Any`


**Return type**: `Number (whole)`

#### Examples

```
COUNT()
```

```
COUNT([OrderID])
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`
