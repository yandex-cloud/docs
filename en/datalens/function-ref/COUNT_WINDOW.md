---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/COUNT_WINDOW.md
---

# COUNT (window)

_Function `COUNT` is also found in the following categories: [Aggregate functions](COUNT.md)._

#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  COUNT(  [ value ]
         TOTAL | WITHIN ... | AMONG ...
       )
  ```

  More info:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)

- Extended

  ```
  COUNT(  [ value ]
         TOTAL | WITHIN ... | AMONG ...
         [ BEFORE FILTER BY ... ]
       )
  ```

  More info:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)
  - [BEFORE FILTER BY](window-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns the number of items in the specified window.

**Argument types:**
- `value` — `Any`


**Return type**: `Integer`

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

| **[City]**        | **[Category]**      | **SUM([Orders])**   | **COUNT(SUM([Orders]) TOTAL)**   | **COUNT(SUM([Orders]) WITHIN [City])**   | **COUNT(SUM([Orders]) AMONG [City])**   |
|:------------------|:--------------------|:--------------------|:---------------------------------|:-----------------------------------------|:----------------------------------------|
| `'Detroit'`       | `'Furniture'`       | `7`                 | `8`                              | `2`                                      | `4`                                     |
| `'Detroit'`       | `'Office Supplies'` | `25`                | `8`                              | `2`                                      | `4`                                     |
| `'London'`        | `'Furniture'`       | `1`                 | `8`                              | `2`                                      | `4`                                     |
| `'London'`        | `'Office Supplies'` | `10`                | `8`                              | `2`                                      | `4`                                     |
| `'Moscow'`        | `'Furniture'`       | `2`                 | `8`                              | `2`                                      | `4`                                     |
| `'Moscow'`        | `'Office Supplies'` | `4`                 | `8`                              | `2`                                      | `4`                                     |
| `'San Francisco'` | `'Furniture'`       | `5`                 | `8`                              | `2`                                      | `4`                                     |
| `'San Francisco'` | `'Office Supplies'` | `23`                | `8`                              | `2`                                      | `4`                                     |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
