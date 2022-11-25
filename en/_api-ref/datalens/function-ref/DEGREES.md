---
editable: false
---

# DEGREES



#### Syntax {#syntax}


```
DEGREES( radians )
```

#### Description {#description}
Converts radians to degrees.

**Argument types:**
- `radians` — `Fractional number | Integer`


**Return type**: `Fractional number`

#### Example {#examples}



| **[n]**   | **[n] &ast; PI()**   | **DEGREES([n]&ast;PI())**   |
|:----------|:---------------------|:----------------------------|
| `-1.00`   | `-3.14`              | `-180.00`                   |
| `-0.50`   | `-1.57`              | `-90.00`                    |
| `-0.25`   | `-0.79`              | `-45.00`                    |
| `0.00`    | `0.00`               | `0.00`                      |
| `0.25`    | `0.79`               | `45.00`                     |
| `0.50`    | `1.57`               | `90.00`                     |
| `1.00`    | `3.14`               | `180.00`                    |




#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
