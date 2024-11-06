---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/ATAN.md
---

# ATAN



#### Syntax {#syntax}


```
ATAN( number )
```

#### Description {#description}
Returns the arctangent of `number` in radians.

**Argument types:**
- `number` — `Fractional number | Integer`


**Return type**: `Fractional number`

#### Example {#examples}



| **[n]**   | **ATAN([n])**   |
|:----------|:----------------|
| `-1.00`   | `-0.79`         |
| `-0.87`   | `-0.71`         |
| `-0.71`   | `-0.62`         |
| `-0.50`   | `-0.46`         |
| `0.00`    | `0.00`          |
| `0.50`    | `0.46`          |
| `0.71`    | `0.62`          |
| `0.87`    | `0.71`          |
| `1.00`    | `0.79`          |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Yandex Documents`, `YDB`.
