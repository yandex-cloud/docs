---
editable: false
---

# AVG_IF

_Aggregate functions_

#### Syntax {#syntax}


```
AVG_IF( expression, condition )
```

#### Description {#description}
Returns the average of all values that meet the `condition` condition. If the values don't exist, it returns `NULL`. Applicable to numeric data types only.

**Argument types:**
- `expression` — `Number`
- `condition` — `Boolean`


**Return type**: `Number (decimal)`

#### Examples {#examples}

```
AVG([Profit], [Profit] > 5)
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.

### As Window Function {#as-window-function}

Function `AVG_IF` is also available as a window function.
#### Syntax {#window-syntax}


```
AVG_IF( expression, condition [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )
```

#### Examples {#window-examples}

```
AVG_IF([Profit], [Category] = 'Office Supplies' TOTAL)
```

```
AVG_IF([Profit], [Category] = 'Office Supplies' WITHIN [Date])
```

```
AVG_IF([Profit], [Category] = 'Office Supplies' AMONG [Date])
```
