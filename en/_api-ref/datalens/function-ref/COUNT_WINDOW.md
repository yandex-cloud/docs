---
editable: false
---

# COUNT (window)

_Function `COUNT` is also found in the following categories: [Aggregate functions](COUNT.md)._

#### Syntax {#syntax}


```
COUNT(  [ value ] [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )
```

#### Description {#description}
Returns the number of items in the specified window.

**Argument types:**
- `value` — `Any`


**Return type**: `Integer`

#### Examples {#examples}

```
COUNT([Profit] TOTAL)
```

```
COUNT([Profit] WITHIN [Date])
```

```
COUNT(AMONG [Date])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
