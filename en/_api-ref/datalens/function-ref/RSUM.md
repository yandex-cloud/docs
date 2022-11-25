---
editable: false
---

# RSUM (window)



#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  RSUM( value [ , direction ] )
  ```

- Extended

  ```
  RSUM( value [ , direction ]
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

Returns the sum of all values in a growing (or shrinking) window defined by the sort order and the value of `direction`:

| `direction`   | Window                                                 |
|:--------------|:-------------------------------------------------------|
| `"asc"`       | Starts from the first row and ends at the current row. |
| `"desc"`      | Starts from the current row and ends at the last row.  |

By default `"asc"` is used.


Window functions with a similar behavior: [RCOUNT](RCOUNT.md), [RMIN](RMIN.md), [RMAX](RMAX.md), [RAVG](RAVG.md).

See also [SUM](SUM.md), [MSUM](MSUM.md).

**Argument types:**
- `value` — `Fractional number | Integer`
- `direction` — `String`


**Return type**: Same type as (`value`)

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

| **[City]**        | **[Category]**      | **SUM([Orders])**   | **RSUM(SUM([Orders]) TOTAL)**   | **RSUM(SUM([Orders]) WITHIN [City])**   | **RSUM(SUM([Orders]) AMONG [City])**   |
|:------------------|:--------------------|:--------------------|:--------------------------------|:----------------------------------------|:---------------------------------------|
| `'Detroit'`       | `'Furniture'`       | `7`                 | `7`                             | `7`                                     | `7`                                    |
| `'Detroit'`       | `'Office Supplies'` | `25`                | `32`                            | `32`                                    | `48`                                   |
| `'London'`        | `'Furniture'`       | `1`                 | `33`                            | `1`                                     | `8`                                    |
| `'London'`        | `'Office Supplies'` | `10`                | `43`                            | `11`                                    | `62`                                   |
| `'Moscow'`        | `'Furniture'`       | `2`                 | `45`                            | `2`                                     | `10`                                   |
| `'Moscow'`        | `'Office Supplies'` | `4`                 | `49`                            | `6`                                     | `52`                                   |
| `'San Francisco'` | `'Furniture'`       | `5`                 | `54`                            | `5`                                     | `15`                                   |
| `'San Francisco'` | `'Office Supplies'` | `23`                | `77`                            | `28`                                    | `23`                                   |

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

| **[City]**        | **SUM([Orders])**   | **RSUM(SUM([Orders]), "desc")**   | **RSUM(SUM([Orders]), "asc" ORDER BY [City] DESC)**   | **RSUM(SUM([Orders]) ORDER BY [Order Sum])**   |
|:------------------|:--------------------|:----------------------------------|:------------------------------------------------------|:-----------------------------------------------|
| `'Detroit'`       | `32`                | `77`                              | `77`                                                  | `77`                                           |
| `'London'`        | `11`                | `45`                              | `45`                                                  | `17`                                           |
| `'Moscow'`        | `6`                 | `34`                              | `34`                                                  | `6`                                            |
| `'San Francisco'` | `28`                | `28`                              | `28`                                                  | `45`                                           |

{% endcut %}


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
