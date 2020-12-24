---
editable: false
---

# AVG

_Function `AVG` is also available as a [window function](AVG_WINDOW.md)._

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

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
