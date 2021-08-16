---
editable: false
---

# SUM

_Function `SUM` is also available as a [window function](SUM_WINDOW.md)._

#### Syntax {#syntax}


```
SUM( value )
```

#### Description {#description}
Returns the sum of all expression values. Applicable to numeric data types only.

**Argument types:**
- `value` — `Fractional number | Integer`


**Return type**: Same type as (`value`)

#### Example {#examples}




Source data

| **City**          | **Category**        | **Orders**   | **Profit**   |
|:------------------|:--------------------|:-------------|:-------------|
| `'London'`        | `'Office Supplies'` | `8`          | `    120.10` |
| `'London'`        | `'Furniture'`       | `1`          | `    750.00` |
| `'Moscow'`        | `'Furniture'`       | `2`          | `   1250.50` |
| `'Moscow'`        | `'Office Supplies'` | `4`          | `     85.34` |
| `'San Francisco'` | `'Office Supplies'` | `23`         | `    723.00` |
| `'Detroit'`       | `'Furniture'`       | `5`          | `   6205.87` |

Grouped by `[City]`.

Sorted by `[City]`.

Result

| **[City]**        | **SUM([Orders])**   | **SUM([Profit])**   |
|:------------------|:--------------------|:--------------------|
| `'Detroit'`       | `5`                 | `   6205.87`        |
| `'London'`        | `9`                 | `    870.10`        |
| `'Moscow'`        | `6`                 | `   1335.84`        |
| `'San Francisco'` | `23`                | `    723.00`        |




#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
