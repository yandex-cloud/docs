---
editable: false
---

# MAX

_Aggregate functions_

#### Syntax {#syntax}


```
MAX( value )
```

#### Description {#description}
Returns the maximum value.

If `value`:
- number — Returns the largest number.
- date — Returns the latest date.
- string — Returns the last value in the alphabetic order.


**Argument types:**
- `value` — `Boolean | Date | Datetime | Number | String | UUID`


**Return type**: Same type as (`value`)

#### Examples {#examples}

```
MAX([Profit])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.

### As Window Function {#as-window-function}

Function `MAX` is also available as a window function.
#### Syntax {#window-syntax}


```
MAX( value [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )
```

#### Examples {#window-examples}

```
MAX([Profit] TOTAL)
```

```
MAX([Profit] WITHIN [Date])
```

```
MAX([Profit] AMONG [Date])
```
