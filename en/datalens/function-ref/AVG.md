---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/AVG.md
---

# AVG

_Function `AVG` is also found in the following categories: [Window functions](AVG_WINDOW.md)._

#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  AVG( value )
  ```

- Extended

  ```
  AVG( value
       [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
       [ BEFORE FILTER BY ... ]
     )
  ```

  More info:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns the average of all values. Applicable to numeric data types as well as `Date`.

**Argument types:**
- `value` — `Date | Datetime | Fractional number | Integer`


**Return type**: Depends on argument types

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
- **Avg Orders**: `AVG([Orders])` ;
- **Avg Profit**: `AVG([Profit])` .


Result

| **City**          | **Avg Orders**   | **Avg Profit**   |
|:------------------|:-----------------|:-----------------|
| `'Detroit'`       | `7.00`           | `4553.43`        |
| `'London'`        | `4.50`           | `435.05`         |
| `'Moscow'`        | `3.00`           | `667.92`         |
| `'San Francisco'` | `17.50`          | `1132.50`        |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
