---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/ZN.md
---

# ZN



#### Syntax {#syntax}


```
ZN( expression )
```

#### Description {#description}
Returns `expression` if it's not `NULL`. Otherwise returns 0.

**Argument types:**
- `expression` — `Fractional number | Integer`


**Return type**: Same type as (`expression`)

#### Example {#examples}



| **[sales]**   | **ZN([sales])**   |
|:--------------|:------------------|
| `432.40`      | `432.40`          |
| `77.00`       | `77.00`           |
| `12000.00`    | `12000.00`        |
| `NULL`        | `0.00`            |
| `34.25`       | `34.25`           |
| `128.00`      | `128.00`          |
| `0.00`        | `0.00`            |
| `NULL`        | `0.00`            |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
