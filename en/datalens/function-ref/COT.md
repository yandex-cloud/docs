---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/COT.md
---

# COT



#### Syntax {#syntax}


```
COT( number )
```

#### Description {#description}
Returns the cotangent of `number` in radians.

**Argument types:**
- `number` — `Fractional number | Integer`


**Return type**: `Fractional number`

#### Example {#examples}



| **[n]**   | **[n] &ast; PI()**   | **COT([n]&ast;PI())**   |
|:----------|:---------------------|:------------------------|
| `-1.00`   | `-3.14`              | `8165619676597685.00`   |
| `-0.50`   | `-1.57`              | `-0.00`                 |
| `-0.25`   | `-0.79`              | `-1.00`                 |
| `0.00`    | `0.00`               | `inf`                   |
| `0.25`    | `0.79`               | `1.00`                  |
| `0.50`    | `1.57`               | `0.00`                  |
| `1.00`    | `3.14`               | `-8165619676597685.00`  |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Yandex Documents`, `YDB`.
