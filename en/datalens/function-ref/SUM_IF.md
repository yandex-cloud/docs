---
editable: false
---

# SUM_IF

_Function `SUM_IF` is also available as a [window function](SUM_IF_WINDOW.md)._

#### Syntax {#syntax}


```
SUM_IF( expression, condition )
```

#### Description {#description}
Returns the sum of all the expression values that meet the `condition` condition. Applicable to numeric data types only.

**Argument types:**
- `expression` — `Fractional number | Integer`
- `condition` — `Boolean`


**Return type**: Same type as (`expression`)

#### Example {#examples}

```
SUM_IF([Profit], [Profit] > 15)
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
