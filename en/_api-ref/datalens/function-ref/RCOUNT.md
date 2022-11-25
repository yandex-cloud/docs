---
editable: false
---

# RCOUNT (window)



#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  RCOUNT( value [ , direction ] )
  ```

- Extended

  ```
  RCOUNT( value [ , direction ]
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

Returns the count of all values in a growing (or shrinking) window defined by the sort order and the value of `direction`:

| `direction`   | Window                                                 |
|:--------------|:-------------------------------------------------------|
| `"asc"`       | Starts from the first row and ends at the current row. |
| `"desc"`      | Starts from the current row and ends at the last row.  |

By default `"asc"` is used.


Window functions with a similar behavior: [RSUM](RSUM.md), [RMIN](RMIN.md), [RMAX](RMAX.md), [RAVG](RAVG.md).

See also [COUNT](COUNT.md), [MCOUNT](MCOUNT.md).

**Argument types:**
- `value` — `Any`
- `direction` — `String`


**Return type**: `Integer`

{% note info %}

Only constant values are accepted for the arguments (`direction`).

{% endnote %}


#### Examples {#examples}

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

| **[City]**        | **[Category]**      | **SUM([Orders])**   | **RCOUNT(SUM([Orders]) TOTAL)**   | **RCOUNT(SUM([Orders]) WITHIN [City])**   | **RCOUNT(SUM([Orders]) AMONG [City])**   |
|:------------------|:--------------------|:--------------------|:----------------------------------|:------------------------------------------|:-----------------------------------------|
| `'Detroit'`       | `'Furniture'`       | `7`                 | `1`                               | `1`                                       | `1`                                      |
| `'Detroit'`       | `'Office Supplies'` | `25`                | `2`                               | `2`                                       | `2`                                      |
| `'London'`        | `'Furniture'`       | `1`                 | `3`                               | `1`                                       | `2`                                      |
| `'London'`        | `'Office Supplies'` | `10`                | `4`                               | `2`                                       | `4`                                      |
| `'Moscow'`        | `'Furniture'`       | `2`                 | `5`                               | `1`                                       | `3`                                      |
| `'Moscow'`        | `'Office Supplies'` | `4`                 | `6`                               | `2`                                       | `3`                                      |
| `'San Francisco'` | `'Furniture'`       | `5`                 | `7`                               | `1`                                       | `4`                                      |
| `'San Francisco'` | `'Office Supplies'` | `23`                | `8`                               | `2`                                       | `1`                                      |

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

| **[City]**        | **SUM([Orders])**   | **RCOUNT(SUM([Orders]), "desc")**   | **RCOUNT(SUM([Orders]), "asc" ORDER BY [City] DESC)**   | **RCOUNT(SUM([Orders]) ORDER BY [Order Sum])**   |
|:------------------|:--------------------|:------------------------------------|:--------------------------------------------------------|:-------------------------------------------------|
| `'Detroit'`       | `32`                | `4`                                 | `4`                                                     | `4`                                              |
| `'London'`        | `11`                | `3`                                 | `3`                                                     | `2`                                              |
| `'Moscow'`        | `6`                 | `2`                                 | `2`                                                     | `1`                                              |
| `'San Francisco'` | `28`                | `1`                                 | `1`                                                     | `3`                                              |

{% endcut %}


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
