---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/COS.md
---

# COS



#### Syntax {#syntax}


```
COS( number )
```

#### Description {#description}
Returns the cosine of `number` in radians.

**Argument types:**
- `number` — `Fractional number | Integer`


**Return type**: `Fractional number`

#### Example {#examples}



| **[n]**   | **[n] &ast; PI()**   | **COS([n]&ast;PI())**   |
|:----------|:---------------------|:------------------------|
| `-1.00`   | `-3.14`              | `-1.00`                 |
| `-0.50`   | `-1.57`              | `0.00`                  |
| `-0.25`   | `-0.79`              | `0.71`                  |
| `0.00`    | `0.00`               | `1.00`                  |
| `0.25`    | `0.79`               | `0.71`                  |
| `0.50`    | `1.57`               | `0.00`                  |
| `1.00`    | `3.14`               | `-1.00`                 |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
