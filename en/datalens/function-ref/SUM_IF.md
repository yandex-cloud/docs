---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/SUM_IF.md
---

# SUM_IF

_Function `SUM_IF` is also found in the following categories: [Window functions](SUM_IF_WINDOW.md)._

#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  SUM_IF( expression, condition )
  ```

- Extended

  ```
  SUM_IF( expression, condition
          [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
          [ BEFORE FILTER BY ... ]
        )
  ```

  More info:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns the sum of all the expression values that meet the `condition` condition. Applicable to numeric data types only.

**Argument types:**
- `expression` — `Fractional number | Integer`
- `condition` — `Boolean`


**Return type**: Same type as (`expression`)

#### Example {#examples}




Source data

| **City**          | **Category**        | **Orders**   | **Profit**   |
|:------------------|:--------------------|:-------------|:-------------|
| `'London'`        | `'Office Supplies'` | `8`          | `120.10`     |
| `'London'`        | `'Furniture'`       | `1`          | `750.00`     |
| `'Moscow'`        | `'Furniture'`       | `2`          | `1250.50`    |
| `'Moscow'`        | `'Office Supplies'` | `4`          | `85.34`      |
| `'San Francisco'` | `'Office Supplies'` | `23`         | `723.00`     |
| `'San Francisco'` | `'Technology'`      | `12`         | `1542.00`    |
| `'Detroit'`       | `'Furniture'`       | `5`          | `6205.87`    |
| `'Detroit'`       | `'Technology'`      | `9`          | `2901.00`    |

Grouped by `[City]`.

Sorted by `[City]`.

Formulas:

- **City**: `[City]` ;
- **Sum Orders**: `SUM_IF([Orders], [Orders] >= 5)` ;
- **Sum Profit**: `SUM_IF([Profit], [Profit] >= 500)` .


Result

| **City**          | **Sum Orders**   | **Sum Profit**   |
|:------------------|:-----------------|:-----------------|
| `'Detroit'`       | `14`             | `9106.87`        |
| `'London'`        | `8`              | `750.00`         |
| `'Moscow'`        | `NULL`           | `1250.50`        |
| `'San Francisco'` | `35`             | `2265.00`        |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
