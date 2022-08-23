---
editable: false
---

# MIN (window)

_Function `MIN` is also found in the following categories: [Aggregate functions](MIN.md)._

#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  MIN( value
       TOTAL | WITHIN ... | AMONG ...
     )
  ```

  More info:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)

- Extended

  ```
  MIN( value
       TOTAL | WITHIN ... | AMONG ...
       [ BEFORE FILTER BY ... ]
     )
  ```

  More info:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)
  - [BEFORE FILTER BY](window-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns the minimum value.

If `value`:
- number — Returns the smallest number.
- date — Returns the earliest date.
- string — Returns the first value in the alphabetic order.


**Argument types:**
- `value` — `Boolean | Date | Datetime | Datetime (deprecated) | Fractional number | Integer | String | UUID`


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

Result

| **[City]**        | **[Category]**      | **SUM([Orders])**   | **MIN(SUM([Orders]) TOTAL)**   | **MIN(SUM([Orders]) WITHIN [City])**   | **MIN(SUM([Orders]) AMONG [City])**   |
|:------------------|:--------------------|:--------------------|:-------------------------------|:---------------------------------------|:--------------------------------------|
| `'Detroit'`       | `'Furniture'`       | `7`                 | `1`                            | `7`                                    | `1`                                   |
| `'Detroit'`       | `'Office Supplies'` | `25`                | `1`                            | `7`                                    | `4`                                   |
| `'London'`        | `'Furniture'`       | `1`                 | `1`                            | `1`                                    | `1`                                   |
| `'London'`        | `'Office Supplies'` | `10`                | `1`                            | `1`                                    | `4`                                   |
| `'Moscow'`        | `'Furniture'`       | `2`                 | `1`                            | `2`                                    | `1`                                   |
| `'Moscow'`        | `'Office Supplies'` | `4`                 | `1`                            | `2`                                    | `4`                                   |
| `'San Francisco'` | `'Furniture'`       | `5`                 | `1`                            | `5`                                    | `1`                                   |
| `'San Francisco'` | `'Office Supplies'` | `23`                | `1`                            | `5`                                    | `4`                                   |




#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
