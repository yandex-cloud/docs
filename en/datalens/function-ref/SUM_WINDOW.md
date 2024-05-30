---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/SUM_WINDOW.md
---

# SUM (window)

_Function `SUM` is also found in the following categories: [Aggregate functions](SUM.md)._

#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  SUM( value
       TOTAL | WITHIN ... | AMONG ...
     )
  ```

  More info:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)

- Extended

  ```
  SUM( value
       TOTAL | WITHIN ... | AMONG ...
       [ BEFORE FILTER BY ... ]
     )
  ```

  More info:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)
  - [BEFORE FILTER BY](window-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns the sum of all expression values. Applicable to numeric data types only.

**Argument types:**
- `value` — `Fractional number | Integer`


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
- **SUM TOTAL**: `SUM(SUM([Orders]) TOTAL)` ;
- **SUM WITHIN**: `SUM(SUM([Orders]) WITHIN [City])` ;
- **SUM AMONG**: `SUM(SUM([Orders]) AMONG [City])` .


Result

| **City**          | **Category**        | **Order Sum**   | **SUM TOTAL**   | **SUM WITHIN**   | **SUM AMONG**   |
|:------------------|:--------------------|:----------------|:----------------|:-----------------|:----------------|
| `'Detroit'`       | `'Furniture'`       | `7`             | `77`            | `32`             | `15`            |
| `'Detroit'`       | `'Office Supplies'` | `25`            | `77`            | `32`             | `62`            |
| `'London'`        | `'Furniture'`       | `1`             | `77`            | `11`             | `15`            |
| `'London'`        | `'Office Supplies'` | `10`            | `77`            | `11`             | `62`            |
| `'Moscow'`        | `'Furniture'`       | `2`             | `77`            | `6`              | `15`            |
| `'Moscow'`        | `'Office Supplies'` | `4`             | `77`            | `6`              | `62`            |
| `'San Francisco'` | `'Furniture'`       | `5`             | `77`            | `28`             | `15`            |
| `'San Francisco'` | `'Office Supplies'` | `23`            | `77`            | `28`             | `62`            |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
