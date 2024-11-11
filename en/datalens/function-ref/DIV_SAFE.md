---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/DIV_SAFE.md
---

# DIV_SAFE



#### Syntax {#syntax}


```
DIV_SAFE( numerator, denominator [ , fallback_value ] )
```

#### Description {#description}
Divides `numerator` by `denominator`. Returns `fallback_value` if division by zero occurs. If the number `fallback_value` is omitted, it is assumed to be `NULL`.
The result is rounded down to the nearest integer.

**Argument types:**
- `numerator` — `Fractional number | Integer`
- `denominator` — `Fractional number | Integer`
- `fallback_value` — `Integer`


**Return type**: `Integer`

#### Example {#examples}



| **[numerator]**   | **[denominator]**   | **DIV_SAFE([numerator], [denominator])**   | **DIV_SAFE([numerator], [denominator], 42)**   |
|:------------------|:--------------------|:-------------------------------------------|:-----------------------------------------------|
| `5.00`            | `2.00`              | `2`                                        | `2`                                            |
| `5.00`            | `0.00`              | `NULL`                                     | `42`                                           |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Yandex Documents`, `YDB`.
