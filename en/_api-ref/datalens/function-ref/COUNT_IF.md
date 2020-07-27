---
editable: false
---

# COUNT_IF

_Aggregate functions_

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

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.

### As Window Function {#as-window-function}

Function `COUNT_IF` is also available as a window function.
#### Syntax {#window-syntax}


```
COUNT_IF( expression, condition [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )
```

#### Examples {#window-examples}

```
COUNT_IF([Profit], [Category] = 'Office Supplies' TOTAL)
```

```
COUNT_IF([Profit], [Category] = 'Office Supplies' WITHIN [Date])
```

```
COUNT_IF([Profit], [Category] = 'Office Supplies' AMONG [Date])
```
