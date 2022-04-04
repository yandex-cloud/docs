---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/AVG.md
---

# AVG

_Function `AVG` is also found in the following categories: [Window functions](AVG_WINDOW.md)._

#### Syntax {#syntax}


```
AVG( value )
```

#### Description {#description}
Returns the average of all values. Applicable to numeric data types as well as `Date | Datetime`.

**Argument types:**
- `value` — `Date | Datetime | Fractional number | Integer`


**Return type**: Depends on argument types

#### Example {#examples}

```
AVG([Profit])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
