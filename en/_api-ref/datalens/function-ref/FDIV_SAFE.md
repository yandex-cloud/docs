---
editable: false
---

# FDIV_SAFE



#### Syntax {#syntax}


```
FDIV_SAFE( numerator, denominator [ , fallback_value ] )
```

#### Description {#description}
Divides `numerator` by `denominator`. Returns `fallback_value` if division by zero occurs. If the number `fallback_value` is omitted, it is assumed to be `NULL`.

**Argument types:**
- `numerator` — `Fractional number | Integer`
- `denominator` — `Fractional number | Integer`
- `fallback_value` — `Fractional number | Integer`


**Return type**: `Fractional number`

#### Example {#examples}



| **[numerator]**   | **[denominator]**   | **FDIV_SAFE([numerator], [denominator])**   | **FDIV_SAFE([numerator], [denominator], 42)**   |
|:------------------|:--------------------|:--------------------------------------------|:------------------------------------------------|
| `5.00`            | `2.00`              | `2.50`                                      | `2.50`                                          |
| `5.00`            | `0.00`              | `NULL`                                      | `42.00`                                         |




#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
