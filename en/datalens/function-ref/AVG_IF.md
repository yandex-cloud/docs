---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/AVG_IF.md
---


# AVG_IF

_Function `AVG_IF` is also found in the following categories: [Window functions](AVG_IF_WINDOW.md)._

#### Syntax {#syntax}


```
AVG_IF( expression, condition )
```

#### Description {#description}
Returns the average of all values that meet the `condition` condition. If the values don't exist, it returns `NULL`. Applicable to numeric data types only.

**Argument types:**
- `expression` — `Fractional number | Integer`
- `condition` — `Boolean`


**Return type**: `Fractional number`

#### Example {#examples}

```
AVG_IF([Profit], [Profit] > 5)
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
