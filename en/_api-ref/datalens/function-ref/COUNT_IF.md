---
editable: false
---

# COUNT_IF

_Function `COUNT_IF` is also available as a [window function](COUNT_IF_WINDOW.md)._

#### Syntax {#syntax}


```
COUNT_IF( condition )
```

#### Description {#description}
Returns the number of items in the group meeting the `condition` condition.

**Argument types:**
- `condition` — `Boolean`


**Return type**: `Number (whole)`

#### Examples {#examples}

```
COUNT_IF([Profit] > 5)
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
