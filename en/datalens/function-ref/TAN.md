---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/TAN.md
---

# TAN



#### Syntax {#syntax}


```
TAN( number )
```

#### Description {#description}
Returns the tangent of `number` in radians.

**Argument types:**
- `number` — `Fractional number | Integer`


**Return type**: `Fractional number`

#### Example {#examples}



| **[n]**   | **[n] &ast; PI()**   | **tan([n]&ast;PI())**   |
|:----------|:---------------------|:------------------------|
| `-1.00`   | `-3.14`              | `0.00`                  |
| `-0.50`   | `-1.57`              | `-16331239353195370.00` |
| `-0.25`   | `-0.79`              | `-1.00`                 |
| `0.00`    | `0.00`               | `0.00`                  |
| `0.25`    | `0.79`               | `1.00`                  |
| `0.50`    | `1.57`               | `16331239353195370.00`  |
| `1.00`    | `3.14`               | `-0.00`                 |




#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
