---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/SQRT.md
---

# SQRT



#### Syntax {#syntax}


```
SQRT( number )
```

#### Description {#description}
Returns the square root of the specified number.

**Argument types:**
- `number` — `Fractional number | Integer`


**Return type**: `Fractional number`

#### Example {#examples}



| **[int_value]**   | **[float_value]**   | **SQRT([int_value])**   | **SQRT([float_value])**   |
|:------------------|:--------------------|:------------------------|:--------------------------|
| `0`               | `0.00`              | `0.00`                  | `0.00`                    |
| `1`               | `1.00`              | `1.00`                  | `1.00`                    |
| `3`               | `3.00`              | `1.73`                  | `1.73`                    |
| `4`               | `4.00`              | `2.00`                  | `2.00`                    |
| `13`              | `13.00`             | `3.61`                  | `3.61`                    |
| `16`              | `16.00`             | `4.00`                  | `4.00`                    |
| `20`              | `20.20`             | `4.47`                  | `4.49`                    |
| `25`              | `25.00`             | `5.00`                  | `5.00`                    |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Yandex Documents`, `YDB`.
