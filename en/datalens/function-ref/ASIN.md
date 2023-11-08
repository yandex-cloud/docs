---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/ASIN.md
---

# ASIN



#### Syntax {#syntax}


```
ASIN( number )
```

#### Description {#description}
Returns the arcsine of `number` in radians.

**Argument types:**
- `number` — `Fractional number | Integer`


**Return type**: `Fractional number`

#### Example {#examples}



| **[n]**   | **ASIN([n])**   |
|:----------|:----------------|
| `-1.00`   | `-1.57`         |
| `-0.87`   | `-1.05`         |
| `-0.71`   | `-0.79`         |
| `-0.50`   | `-0.52`         |
| `0.00`    | `0.00`          |
| `0.50`    | `0.52`          |
| `0.71`    | `0.79`          |
| `0.87`    | `1.05`          |
| `1.00`    | `1.57`          |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
