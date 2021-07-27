---
editable: false

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# MAX

_Function `MAX` is also available as a [window function](MAX_WINDOW.md)._

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
- `value` — `Boolean | Date | Datetime | Fractional number | Integer | String | UUID`


**Return type**: Same type as (`value`)

#### Examples {#examples}

```
MAX([Profit])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
