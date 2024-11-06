---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/AVG_WINDOW.md
---

# AVG (window)

_Function `AVG` is also found in the following categories: [Aggregate functions](AVG.md)._

#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  AVG( value
       TOTAL | WITHIN ... | AMONG ...
     )
  ```

  More info:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)

- Extended

  ```
  AVG( value
       TOTAL | WITHIN ... | AMONG ...
       [ BEFORE FILTER BY ... ]
     )
  ```

  More info:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)
  - [BEFORE FILTER BY](window-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns the average of all values. Applicable to numeric data types.

**Argument types:**
- `value` — `Any`


**Return type**: `Fractional number`

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
- **AVG TOTAL**: `AVG(SUM([Orders]) TOTAL)` ;
- **AVG WITHIN**: `AVG(SUM([Orders]) WITHIN [City])` ;
- **AVG AMONG**: `AVG(SUM([Orders]) AMONG [City])` .


Result

| **City**          | **Category**        | **Order Sum**   | **AVG TOTAL**   | **AVG WITHIN**   | **AVG AMONG**   |
|:------------------|:--------------------|:----------------|:----------------|:-----------------|:----------------|
| `'Detroit'`       | `'Furniture'`       | `7`             | `9.62`          | `16.00`          | `3.75`          |
| `'Detroit'`       | `'Office Supplies'` | `25`            | `9.62`          | `16.00`          | `15.50`         |
| `'London'`        | `'Furniture'`       | `1`             | `9.62`          | `5.50`           | `3.75`          |
| `'London'`        | `'Office Supplies'` | `10`            | `9.62`          | `5.50`           | `15.50`         |
| `'Moscow'`        | `'Furniture'`       | `2`             | `9.62`          | `3.00`           | `3.75`          |
| `'Moscow'`        | `'Office Supplies'` | `4`             | `9.62`          | `3.00`           | `15.50`         |
| `'San Francisco'` | `'Furniture'`       | `5`             | `9.62`          | `14.00`          | `3.75`          |
| `'San Francisco'` | `'Office Supplies'` | `23`            | `9.62`          | `14.00`          | `15.50`         |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Yandex Documents`.
