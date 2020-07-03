---
editable: false
---

# SUM

_Aggregate functions_

#### Syntax {#syntax}


```
SUM( value )
```

#### Description {#description}
Returns the sum of all expression values. Applicable to numeric data types only.

**Argument types:**
- `value` — `Number`


**Return type**: Same type as (`value`)

#### Examples {#examples}

```
SUM([Profit])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.

### As Window Function {#as-window-function}

Function `SUM` is also available as a window function.
#### Syntax {#window-syntax}


```
SUM( value [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )
```

#### Examples {#window-examples}

```
SUM([Profit] TOTAL)
```

```
SUM([Profit] WITHIN [Date])
```

```
SUM([Profit] AMONG [Date])
```
