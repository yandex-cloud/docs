---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/DIV.md
---

# DIV



#### Syntax {#syntax}


```
DIV( number_1, number_2 )
```

#### Description {#description}
Divides `number_1` by `number_2`. The result is rounded down to the nearest integer.

**Argument types:**
- `number_1` — `Fractional number | Integer`
- `number_2` — `Fractional number | Integer`


**Return type**: `Integer`

#### Example {#examples}



| **[numerator]**   | **[denominator]**   | **DIV([numerator], [denominator])**   |
|:------------------|:--------------------|:--------------------------------------|
| `4.00`            | `2.00`              | `2`                                   |
| `5.00`            | `3.00`              | `1`                                   |
| `5.00`            | `2.00`              | `2`                                   |
| `2.50`            | `1.20`              | `2`                                   |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Yandex Documents`, `YDB`.
