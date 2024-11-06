---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/AVG_IF_WINDOW.md
---

# AVG_IF (window)

_Function `AVG_IF` is also found in the following categories: [Aggregate functions](AVG_IF.md)._

#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  AVG_IF( expression, condition
          TOTAL | WITHIN ... | AMONG ...
        )
  ```

  More info:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)

- Extended

  ```
  AVG_IF( expression, condition
          TOTAL | WITHIN ... | AMONG ...
          [ BEFORE FILTER BY ... ]
        )
  ```

  More info:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)
  - [BEFORE FILTER BY](window-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns the average of all values that meet the `condition` condition. If the values don't exist, it returns `NULL`. Applicable to numeric data types only.

**Argument types:**
- `expression` — `Fractional number | Integer`
- `condition` — `Boolean`


**Return type**: Same type as (`expression`)

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

Grouped by `[Date]`, `[Category]`.

Sorted by `[Date]`, `[Category]`.

Formulas:

- **Date**: `[Date]` ;
- **Category**: `[Category]` ;
- **Profit**: `SUM([Profit])` ;
- **AVG_IF TOTAL**: `AVG_IF(SUM([Profit]), [Category] = 'Furniture' TOTAL)` ;
- **AVG_IF WITHIN**: `AVG_IF(SUM([Profit]), [Category] = 'Furniture' WITHIN [Date])` ;
- **AVG_IF AMONG**: `AVG_IF(SUM([Profit]), [Category] = 'Furniture' AMONG [Date])` .


Result

| **Date**       | **Category**        | **Profit**   | **AVG_IF TOTAL**   | **AVG_IF WITHIN**   | **AVG_IF AMONG**   |
|:---------------|:--------------------|:-------------|:-------------------|:--------------------|:-------------------|
| `'2019-03-01'` | `'Furniture'`       | `1000.00`    | `2840.10`          | `1000.00`           | `2840.10`          |
| `'2019-03-01'` | `'Office Supplies'` | `843.80`     | `2840.10`          | `1000.00`           | `NULL`             |
| `'2019-03-02'` | `'Furniture'`       | `4950.50`    | `2840.10`          | `4950.50`           | `2840.10`          |
| `'2019-03-03'` | `'Furniture'`       | `4000.00`    | `2840.10`          | `4000.00`           | `2840.10`          |
| `'2019-03-03'` | `'Office Supplies'` | `85.00`      | `2840.10`          | `4000.00`           | `NULL`             |
| `'2019-03-04'` | `'Furniture'`       | `3500.00`    | `2840.10`          | `3500.00`           | `2840.10`          |
| `'2019-03-04'` | `'Office Supplies'` | `1300.00`    | `2840.10`          | `3500.00`           | `NULL`             |
| `'2019-03-05'` | `'Furniture'`       | `750.00`     | `2840.10`          | `750.00`            | `2840.10`          |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Yandex Documents`.
