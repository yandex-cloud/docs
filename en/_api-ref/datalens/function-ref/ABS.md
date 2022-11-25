---
editable: false
---

# ABS



#### Syntax {#syntax}


```
ABS( number )
```

#### Description {#description}
Returns the absolute value of `number`.

**Argument types:**
- `number` — `Fractional number | Integer`


**Return type**: Same type as (`number`)

#### Example {#examples}



| **[value]**   | **ABS([value])**   |
|:--------------|:-------------------|
| `1.00`        | `1.00`             |
| `0.10`        | `0.10`             |
| `-2.00`       | `2.00`             |
| `50.50`       | `50.50`            |
| `0.00`        | `0.00`             |
| `-3.50`       | `3.50`             |




#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
