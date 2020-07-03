---
editable: false
---

# AVG

_Aggregate functions_

#### Syntax {#syntax}


```
AVG( value )
```

#### Description {#description}
Returns the average of all values. Applicable to numeric data types as well as `Date | Datetime`.

**Argument types:**
- `value` — `Date | Datetime | Number`


**Return type**: Depends on argument types

#### Examples {#examples}

```
AVG([Profit])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.

### As Window Function {#as-window-function}

Function `AVG` is also available as a window function.
#### Syntax {#window-syntax}


```
AVG( value [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )
```

#### Examples {#window-examples}

```
AVG([Profit] TOTAL)
```

```
AVG([Profit] WITHIN [Date])
```

```
AVG([Profit] AMONG [Date])
```
