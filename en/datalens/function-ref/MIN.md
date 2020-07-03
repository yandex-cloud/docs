---
editable: false
---

# MIN

_Aggregate functions_

#### Syntax {#syntax}


```
MIN( value )
```

#### Description {#description}
Returns the minimum value.

If `value`:
- number — Returns the smallest number.
- date — Returns the earliest date.
- string — Returns the first value in the alphabetic order.


**Argument types:**
- `value` — `Boolean | Date | Datetime | Number | String | UUID`


**Return type**: Same type as (`value`)

#### Examples {#examples}

```
MIN([Profit])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.

### As Window Function {#as-window-function}

Function `MIN` is also available as a window function.
#### Syntax {#window-syntax}


```
MIN( value [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )
```

#### Examples {#window-examples}

```
MIN([Profit] TOTAL)
```

```
MIN([Profit] WITHIN [Date])
```

```
MIN([Profit] AMONG [Date])
```
