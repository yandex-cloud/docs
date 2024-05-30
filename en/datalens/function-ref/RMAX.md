---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/RMAX.md
---

# RMAX (window)



#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  RMAX( value [ , direction ] )
  ```

- Extended

  ```
  RMAX( value [ , direction ]
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

Returns the maximum of all values in a growing (or shrinking) window defined by the sort order and the value of `direction`:

| `direction`   | Window                                                 |
|:--------------|:-------------------------------------------------------|
| `"asc"`       | Starts from the first row and ends at the current row. |
| `"desc"`      | Starts from the current row and ends at the last row.  |

By default `"asc"` is used.


Window functions with a similar behavior: [RSUM](RSUM.md), [RCOUNT](RCOUNT.md), [RMIN](RMIN.md), [RAVG](RAVG.md).

See also [MAX](MAX.md), [MMAX](MMAX.md).

**Argument types:**
- `value` — `Boolean | Date | Datetime | Fractional number | Integer | String | UUID`
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

Formulas:

- **City**: `[City]` ;
- **Category**: `[Category]` ;
- **Order Sum**: `SUM([Orders])` ;
- **RMAX TOTAL**: `RMAX(SUM([Orders]) TOTAL)` ;
- **RMAX WITHIN**: `RMAX(SUM([Orders]) WITHIN [City])` ;
- **RMAX AMONG**: `RMAX(SUM([Orders]) AMONG [City])` .


Result

| **City**          | **Category**        | **Order Sum**   | **RMAX TOTAL**   | **RMAX WITHIN**   | **RMAX AMONG**   |
|:------------------|:--------------------|:----------------|:-----------------|:------------------|:-----------------|
| `'Detroit'`       | `'Furniture'`       | `7`             | `7`              | `7`               | `7`              |
| `'Detroit'`       | `'Office Supplies'` | `25`            | `25`             | `25`              | `25`             |
| `'London'`        | `'Furniture'`       | `1`             | `25`             | `1`               | `7`              |
| `'London'`        | `'Office Supplies'` | `10`            | `25`             | `10`              | `25`             |
| `'Moscow'`        | `'Furniture'`       | `2`             | `25`             | `2`               | `7`              |
| `'Moscow'`        | `'Office Supplies'` | `4`             | `25`             | `4`               | `25`             |
| `'San Francisco'` | `'Furniture'`       | `5`             | `25`             | `5`               | `7`              |
| `'San Francisco'` | `'Office Supplies'` | `23`            | `25`             | `23`              | `25`             |

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
- **RMAX 1**: `RMAX(SUM([Orders]), "desc")` ;
- **RMAX 2**: `RMAX(SUM([Orders]), "asc" ORDER BY [City] DESC)` ;
- **RMAX 3**: `RMAX(SUM([Orders]) ORDER BY [Order Sum])` .


Result

| **City**          | **Order Sum**   | **RMAX 1**   | **RMAX 2**   | **RMAX 3**   |
|:------------------|:----------------|:-------------|:-------------|:-------------|
| `'Detroit'`       | `32`            | `32`         | `32`         | `32`         |
| `'London'`        | `11`            | `28`         | `28`         | `11`         |
| `'Moscow'`        | `6`             | `28`         | `28`         | `6`          |
| `'San Francisco'` | `28`            | `28`         | `28`         | `28`         |

{% endcut %}


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
