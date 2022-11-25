---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/ISNULL.md
---

# ISNULL



#### Syntax {#syntax}

As a function
```
ISNULL( expression )
```
As an operator
```
expression IS [ NOT ] NULL
```

#### Description {#description}
Returns `TRUE` if `expression` is `NULL`, otherwise returns `FALSE`.

`expression IS NOT NULL` returns the opposite result.

**Argument types:**
- `expression` — `Any`


**Return type**: `Boolean`

#### Example {#examples}



| **[sales]**   | **ISNULL([sales])**   | **[sales] IS NULL**   | **[sales] IS NOT NULL**   |
|:--------------|:----------------------|:----------------------|:--------------------------|
| `432.40`      | `False`               | `False`               | `True`                    |
| `77.00`       | `False`               | `False`               | `True`                    |
| `12000.00`    | `False`               | `False`               | `True`                    |
| `NULL`        | `True`                | `True`                | `False`                   |
| `34.25`       | `False`               | `False`               | `True`                    |
| `128.00`      | `False`               | `False`               | `True`                    |
| `0.00`        | `False`               | `False`               | `True`                    |
| `NULL`        | `True`                | `True`                | `False`                   |




#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
