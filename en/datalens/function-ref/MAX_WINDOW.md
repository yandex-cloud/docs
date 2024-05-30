---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/MAX_WINDOW.md
---

# MAX (window)

_Function `MAX` is also found in the following categories: [Aggregate functions](MAX.md)._

#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  MAX( value
       TOTAL | WITHIN ... | AMONG ...
     )
  ```

  More info:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)

- Extended

  ```
  MAX( value
       TOTAL | WITHIN ... | AMONG ...
       [ BEFORE FILTER BY ... ]
     )
  ```

  More info:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)
  - [BEFORE FILTER BY](window-functions.md#syntax-before-filter-by)

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

| **Date**       | **City**          | **Category**        | **Orders**   | **Profit**   |
|:---------------|:------------------|:--------------------|:-------------|:-------------|
| `'2019-03-01'` | `'London'`        | `'Office Supplies'` | `8`          | `120.80`     |
| `'2019-03-04'` | `'London'`        | `'Office Supplies'` | `2`          | `100.00`     |
| `'2019-03-05'` | `'London'`        | `'Furniture'`       | `1`          | `750.00`     |
| `'2019-03-02'` | `'Moscow'`        | `'Furniture'`       | `2`          | `1250.50`    |
| `'2019-03-03'` | `'Moscow'`        | `'Office Supplies'` | `4`          | `85.00`      |
| `'2019-03-01'` | `'San Francisco'` | `'Office Supplies'` | `23`         | `723.00`     |
| `'2019-03-01'` | `'San Francisco'` | `'Furniture'`       | `1`          | `1000.00`    |
| `'2019-03-03'` | `'San Francisco'` | `'Furniture'`       | `4`          | `4000.00`    |
| `'2019-03-02'` | `'Detroit'`       | `'Furniture'`       | `5`          | `3700.00`    |
| `'2019-03-04'` | `'Detroit'`       | `'Office Supplies'` | `25`         | `1200.00`    |
| `'2019-03-04'` | `'Detroit'`       | `'Furniture'`       | `2`          | `3500.00`    |

Grouped by `[City]`, `[Category]`.

Sorted by `[City]`, `[Category]`.

Formulas:

- **City**: `[City]` ;
- **Category**: `[Category]` ;
- **Order Sum**: `SUM([Orders])` ;
- **MAX TOTAL**: `MAX(SUM([Orders]) TOTAL)` ;
- **MAX WITHIN**: `MAX(SUM([Orders]) WITHIN [City])` ;
- **MAX AMONG**: `MAX(SUM([Orders]) AMONG [City])` .


Result

| **City**          | **Category**        | **Order Sum**   | **MAX TOTAL**   | **MAX WITHIN**   | **MAX AMONG**   |
|:------------------|:--------------------|:----------------|:----------------|:-----------------|:----------------|
| `'Detroit'`       | `'Furniture'`       | `7`             | `25`            | `25`             | `7`             |
| `'Detroit'`       | `'Office Supplies'` | `25`            | `25`            | `25`             | `25`            |
| `'London'`        | `'Furniture'`       | `1`             | `25`            | `10`             | `7`             |
| `'London'`        | `'Office Supplies'` | `10`            | `25`            | `10`             | `25`            |
| `'Moscow'`        | `'Furniture'`       | `2`             | `25`            | `4`              | `7`             |
| `'Moscow'`        | `'Office Supplies'` | `4`             | `25`            | `4`              | `25`            |
| `'San Francisco'` | `'Furniture'`       | `5`             | `25`            | `23`             | `7`             |
| `'San Francisco'` | `'Office Supplies'` | `23`            | `25`            | `23`             | `25`            |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
