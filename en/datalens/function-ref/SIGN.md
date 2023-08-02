---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/SIGN.md
---

# SIGN



#### Syntax {#syntax}


```
SIGN( number )
```

#### Description {#description}
Returns the sign of the number `number`:
- `-1` if the number is negative.
`0` if the number is zero.
- `1` if the number is positive.

**Argument types:**
- `number` — `Fractional number | Integer`


**Return type**: `Integer`

#### Example {#examples}



| **[value]**   | **SIGN([value])**   |
|:--------------|:--------------------|
| `1.00`        | `1`                 |
| `0.10`        | `1`                 |
| `-2.00`       | `-1`                |
| `50.50`       | `1`                 |
| `0.00`        | `0`                 |
| `-3.50`       | `-1`                |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
