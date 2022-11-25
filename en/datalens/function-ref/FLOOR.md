---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/FLOOR.md
---

# FLOOR



#### Syntax {#syntax}


```
FLOOR( number )
```

#### Description {#description}
Rounds the value down to the nearest integer.

**Argument types:**
- `number` — `Fractional number | Integer`


**Return type**: `Fractional number`

#### Example {#examples}



| **[value]**   | **FLOOR([value])**   |
|:--------------|:---------------------|
| `1.00`        | `1.00`               |
| `0.10`        | `0.00`               |
| `-2.00`       | `-2.00`              |
| `50.50`       | `50.00`              |
| `0.00`        | `0.00`               |
| `-3.50`       | `-4.00`              |




#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
