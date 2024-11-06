---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/SQUARE.md
---

# SQUARE



#### Syntax {#syntax}


```
SQUARE( number )
```

#### Description {#description}
Returns the number `number` raised to the power of 2.

**Argument types:**
- `number` — `Fractional number | Integer`


**Return type**: Same type as (`number`)

#### Example {#examples}



| **[int_value]**   | **[float_value]**   | **SQUARE([int_value])**   | **SQUARE([float_value])**   |
|:------------------|:--------------------|:--------------------------|:----------------------------|
| `0`               | `0.00`              | `0.00`                    | `0.00`                      |
| `1`               | `1.00`              | `1.00`                    | `1.00`                      |
| `3`               | `3.00`              | `9.00`                    | `9.00`                      |
| `4`               | `4.00`              | `16.00`                   | `16.00`                     |
| `13`              | `13.00`             | `169.00`                  | `169.00`                    |
| `16`              | `16.00`             | `256.00`                  | `256.00`                    |
| `20`              | `20.20`             | `400.00`                  | `408.04`                    |
| `25`              | `25.00`             | `625.00`                  | `625.00`                    |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Yandex Documents`, `YDB`.
