---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/MIN.md
---


# MIN

_Function `MIN` is also available as a [window function](MIN_WINDOW.md)._

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
- `value` — `Boolean | Date | Datetime | Fractional number | Integer | String | UUID`


**Return type**: Same type as (`value`)

#### Example {#examples}

```
MIN([Profit])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
