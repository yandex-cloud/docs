---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/RAVG.md
---

# RAVG (window)



#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  RAVG( value [ , direction ] )
  ```

- Extended

  ```
  RAVG( value [ , direction ]
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

Returns the average of all values in a growing (or shrinking) window defined by the sort order and the value of `direction`:

| `direction`   | Window                                                 |
|:--------------|:-------------------------------------------------------|
| `"asc"`       | Starts from the first row and ends at the current row. |
| `"desc"`      | Starts from the current row and ends at the last row.  |

By default `"asc"` is used.


Window functions with a similar behavior: [RSUM](RSUM.md), [RCOUNT](RCOUNT.md), [RMIN](RMIN.md), [RMAX](RMAX.md).

See also [AVG](AVG.md), [MAVG](MAVG.md).

**Argument types:**
- `value` — `Fractional number | Integer`
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

Formulas:

- **City**: `[City]` ;
- **Category**: `[Category]` ;
- **Order Sum**: `SUM([Orders])` ;
- **RAVG TOTAL**: `RAVG(SUM([Orders]) TOTAL)` ;
- **RAVG WITHIN**: `RAVG(SUM([Orders]) WITHIN [City])` ;
- **RAVG AMONG**: `RAVG(SUM([Orders]) AMONG [City])` .


Result

| **City**          | **Category**        | **Order Sum**   | **RAVG TOTAL**   | **RAVG WITHIN**   | **RAVG AMONG**   |
|:------------------|:--------------------|:----------------|:-----------------|:------------------|:-----------------|
| `'Detroit'`       | `'Furniture'`       | `7`             | `7.00`           | `7.00`            | `7.00`           |
| `'Detroit'`       | `'Office Supplies'` | `25`            | `16.00`          | `16.00`           | `25.00`          |
| `'London'`        | `'Furniture'`       | `1`             | `11.00`          | `1.00`            | `4.00`           |
| `'London'`        | `'Office Supplies'` | `10`            | `10.75`          | `5.50`            | `17.50`          |
| `'Moscow'`        | `'Furniture'`       | `2`             | `9.00`           | `2.00`            | `3.33`           |
| `'Moscow'`        | `'Office Supplies'` | `4`             | `8.17`           | `3.00`            | `13.00`          |
| `'San Francisco'` | `'Furniture'`       | `5`             | `7.71`           | `5.00`            | `3.75`           |
| `'San Francisco'` | `'Office Supplies'` | `23`            | `9.62`           | `14.00`           | `15.50`          |

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

Formulas:

- **City**: `[City]` ;
- **Order Sum**: `SUM([Orders])` ;
- **RAVG 1**: `RAVG(SUM([Orders]), "desc")` ;
- **RAVG 2**: `RAVG(SUM([Orders]), "asc" ORDER BY [City] DESC)` ;
- **RAVG 3**: `RAVG(SUM([Orders]) ORDER BY [Order Sum])` .


Result

| **City**          | **Order Sum**   | **RAVG 1**   | **RAVG 2**   | **RAVG 3**   |
|:------------------|:----------------|:-------------|:-------------|:-------------|
| `'Detroit'`       | `32`            | `19.25`      | `19.25`      | `19.25`      |
| `'London'`        | `11`            | `15.00`      | `15.00`      | `8.50`       |
| `'Moscow'`        | `6`             | `17.00`      | `17.00`      | `6.00`       |
| `'San Francisco'` | `28`            | `28.00`      | `28.00`      | `15.00`      |

{% endcut %}


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
