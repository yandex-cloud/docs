---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/CEILING.md
---

# CEILING



#### Syntax {#syntax}


```
CEILING( number )
```

#### Description {#description}
Rounds the value up to the nearest integer.

**Argument types:**
- `number` — `Fractional number | Integer`


**Return type**: `Fractional number`

#### Example {#examples}



| **[value]**   | **CEILING([value])**   |
|:--------------|:-----------------------|
| `1.00`        | `1.00`                 |
| `0.10`        | `1.00`                 |
| `-2.00`       | `-2.00`                |
| `50.50`       | `51.00`                |
| `0.00`        | `0.00`                 |
| `-3.50`       | `-3.00`                |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
