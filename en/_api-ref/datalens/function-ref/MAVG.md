---
editable: false
---

# MAVG (window)



#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  MAVG( value, rows_1 [ , rows_2 ] )
  ```

- Extended

  ```
  MAVG( value, rows_1 [ , rows_2 ]
        [ TOTAL | WITHIN ... | AMONG ... ]
        [ ORDER BY ... ]
        [ BEFORE FILTER BY ... ]
      )
  ```

  More info:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)
  - [ORDER BY](window-functions.md#syntax-order-by)
  - [BEFORE FILTER BY](window-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}

{% note warning %}

The sorting order is based on the fields listed in the sorting section of the chart and in the `ORDER BY` clause. First, `ORDER BY` fields are used, and then they are complemented by the fields from the chart.

{% endnote %}

Returns the moving average of values in a fixed-size window defined by the sort order and arguments:

| `rows_1`   | `rows_2`   | Window                                                                |
|:-----------|:-----------|:----------------------------------------------------------------------|
| positive   | -          | The current row and `rows_1` preceding rows.                          |
| negative   | -          | The current row and -`rows_1` following rows.                         |
| any sign   | any sign   | `rows_1` preceding rows, the current row and `rows_2` following rows. |


Window functions with a similar behavior: [MSUM](MSUM.md), [MCOUNT](MCOUNT.md), [MMIN](MMIN.md), [MMAX](MMAX.md).

See also [AVG](AVG.md), [RAVG](RAVG.md).

**Argument types:**
- `value` — `Fractional number | Integer`
- `rows_1` — `Integer`
- `rows_2` — `Integer`


**Return type**: Same type as (`value`)

{% note info %}

Only constant values are accepted for the arguments (`rows_1`, `rows_2`).

{% endnote %}


#### Examples {#examples}

{% cut "Example with two and three arguments" %}


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

Grouped by `[City]`.

Sorted by `[City]`.

Result

| **[City]**        | **SUM([Orders])**   | **MAVG(SUM([Orders]), 1)**   | **MAVG(SUM([Orders]), -2)**   | **MAVG(SUM([Orders]) 1, 1)**   |
|:------------------|:--------------------|:-----------------------------|:------------------------------|:-------------------------------|
| `'Detroit'`       | `32`                | `32.00`                      | `16.33`                       | `21.50`                        |
| `'London'`        | `11`                | `21.50`                      | `15.00`                       | `16.33`                        |
| `'Moscow'`        | `6`                 | `8.50`                       | `17.00`                       | `15.00`                        |
| `'San Francisco'` | `28`                | `17.00`                      | `28.00`                       | `17.00`                        |

{% endcut %}

{% cut "Example with ORDER BY" %}


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

Grouped by `[City]`.

Sorted by `[City]`.

Result

| **[City]**        | **SUM([Orders])**   | **MAVG(SUM([Orders]), 1 ORDER BY [City] DESC)**   | **MAVG(SUM([Orders]), 1 ORDER BY [Order Sum])**   |
|:------------------|:--------------------|:--------------------------------------------------|:--------------------------------------------------|
| `'Detroit'`       | `32`                | `21.50`                                           | `30.00`                                           |
| `'London'`        | `11`                | `8.50`                                            | `8.50`                                            |
| `'Moscow'`        | `6`                 | `17.00`                                           | `6.00`                                            |
| `'San Francisco'` | `28`                | `28.00`                                           | `19.50`                                           |

{% endcut %}

{% cut "Example with grouping" %}


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

| **[City]**        | **[Category]**      | **SUM([Orders])**   | **MAVG(SUM([Orders]), 1 TOTAL)**   | **MAVG(SUM([Orders]), 1 WITHIN [City])**   | **MAVG(SUM([Orders]), 1 AMONG [City])**   |
|:------------------|:--------------------|:--------------------|:-----------------------------------|:-------------------------------------------|:------------------------------------------|
| `'Detroit'`       | `'Furniture'`       | `7`                 | `7.00`                             | `7.00`                                     | `7.00`                                    |
| `'Detroit'`       | `'Office Supplies'` | `25`                | `16.00`                            | `16.00`                                    | `24.00`                                   |
| `'London'`        | `'Furniture'`       | `1`                 | `13.00`                            | `1.00`                                     | `4.00`                                    |
| `'London'`        | `'Office Supplies'` | `10`                | `5.50`                             | `5.50`                                     | `7.00`                                    |
| `'Moscow'`        | `'Furniture'`       | `2`                 | `6.00`                             | `2.00`                                     | `1.50`                                    |
| `'Moscow'`        | `'Office Supplies'` | `4`                 | `3.00`                             | `3.00`                                     | `14.50`                                   |
| `'San Francisco'` | `'Furniture'`       | `5`                 | `4.50`                             | `5.00`                                     | `3.50`                                    |
| `'San Francisco'` | `'Office Supplies'` | `23`                | `14.00`                            | `14.00`                                    | `23.00`                                   |

{% endcut %}


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
