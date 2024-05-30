---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/SUM.md
---

# SUM

_Function `SUM` is also found in the following categories: [Window functions](SUM_WINDOW.md)._

#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  SUM( value )
  ```

- Extended

  ```
  SUM( value
       [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
       [ BEFORE FILTER BY ... ]
     )
  ```

  More info:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns the sum of all expression values. Applicable to numeric data types only.

**Argument types:**
- `value` — `Fractional number | Integer`


**Return type**: Same type as (`value`)

#### Example {#examples}




Source data

| **City**          | **Category**        | **Orders**   | **Profit**   |
|:------------------|:--------------------|:-------------|:-------------|
| `'London'`        | `'Office Supplies'` | `8`          | `120.10`     |
| `'London'`        | `'Furniture'`       | `1`          | `750.00`     |
| `'Moscow'`        | `'Furniture'`       | `2`          | `1250.50`    |
| `'Moscow'`        | `'Office Supplies'` | `4`          | `85.34`      |
| `'San Francisco'` | `'Office Supplies'` | `23`         | `723.00`     |
| `'Detroit'`       | `'Furniture'`       | `5`          | `6205.87`    |

Grouped by `[City]`.

Sorted by `[City]`.

Formulas:

- **City**: `[City]` ;
- **Sum Orders**: `SUM([Orders])` ;
- **Sum Profit**: `SUM([Profit])` .


Result

| **City**          | **Sum Orders**   | **Sum Profit**   |
|:------------------|:-----------------|:-----------------|
| `'Detroit'`       | `5`              | `6205.87`        |
| `'London'`        | `9`              | `870.10`         |
| `'Moscow'`        | `6`              | `1335.84`        |
| `'San Francisco'` | `23`             | `723.00`         |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
