---
editable: false
---

# SUM

_Function `SUM` is also available as a [window function](SUM_WINDOW.md)._

#### Syntax {#syntax}


```
SUM( value )
```

#### Description {#description}
Returns the sum of all expression values. Applicable to numeric data types only.

**Argument types:**
- `value` — `Fractional number | Integer`


**Return type**: Same type as (`value`)

#### Examples {#examples}

```
SUM([Profit])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
