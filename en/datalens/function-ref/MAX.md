---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/MAX.md
---

# MAX

_Function `MAX` is also found in the following categories: [Window functions](MAX_WINDOW.md)._

#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  MAX( value )
  ```

- Extended

  ```
  MAX( value
       [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
       [ BEFORE FILTER BY ... ]
     )
  ```

  More info:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns the maximum value.

If `value`:
- number — Returns the largest number.
- date — Returns the latest date.
- string — Returns the last value in the alphabetic order.


**Argument types:**
- `value` — `Boolean | Date | Datetime | Fractional number | Integer | String | UUID`


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
| `'San Francisco'` | `'Technology'`      | `12`         | `1542.00`    |
| `'Detroit'`       | `'Furniture'`       | `5`          | `6205.87`    |
| `'Detroit'`       | `'Technology'`      | `9`          | `2901.00`    |

Grouped by `[City]`.

Sorted by `[City]`.

Formulas:

- **City**: `[City]` ;
- **Max Orders**: `MAX([Orders])` ;
- **Max Profit**: `MAX([Profit])` .


Result

| **City**          | **Max Orders**   | **Max Profit**   |
|:------------------|:-----------------|:-----------------|
| `'Detroit'`       | `9`              | `6205.87`        |
| `'London'`        | `8`              | `750.00`         |
| `'Moscow'`        | `4`              | `1250.50`        |
| `'San Francisco'` | `23`             | `1542.00`        |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
