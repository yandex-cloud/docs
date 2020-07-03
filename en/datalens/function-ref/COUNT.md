---
editable: false
---

# COUNT

_Aggregate functions_

#### Syntax {#syntax}


```
COUNT(  [ value ] )
```

#### Description {#description}
Returns the number of items in the group.

**Argument types:**
- `value` — `Any`


**Return type**: `Number (whole)`

#### Examples {#examples}

```
COUNT()
```

```
COUNT([OrderID])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.

### As Window Function {#as-window-function}

Function `COUNT` is also available as a window function.
#### Syntax {#window-syntax}


```
COUNT(  [ value ] [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )
```

#### Examples {#window-examples}

```
COUNT([Profit] TOTAL)
```

```
COUNT(TOTAL)
```

```
COUNT([Profit] WITHIN [Date])
```

```
COUNT(AMONG [Date])
```
