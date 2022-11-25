---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/ACOS.md
---

# ACOS



#### Syntax {#syntax}


```
ACOS( number )
```

#### Description {#description}
Returns the arccosine of `number` in radians.

**Argument types:**
- `number` — `Fractional number | Integer`


**Return type**: `Fractional number`

#### Example {#examples}



| **[n]**   | **ACOS([n])**   |
|:----------|:----------------|
| `-1.00`   | `3.14`          |
| `-0.87`   | `2.62`          |
| `-0.71`   | `2.36`          |
| `-0.50`   | `2.09`          |
| `0.00`    | `1.57`          |
| `0.50`    | `1.05`          |
| `0.71`    | `0.79`          |
| `0.87`    | `0.52`          |
| `1.00`    | `0.00`          |




#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
