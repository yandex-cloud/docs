---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/LAG.md
---

# LAG (window)



#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  LAG( value [ , offset [ , default ] ] )
  ```

- Extended

  ```
  LAG( value [ , offset [ , default ] ]
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

Returns `value` re-evaluated against the row that is offset from the current row by `offset` within the specified window:
- Positive `offset` seeks among preceding rows.
- Negative `offset` seeks among following rows.

By default `offset` is `1`.

If there is no available value (`offset` reaches before the first row or after the last one), then `default` is returned. If `default` is not specified, then `NULL` is used.

See also [AGO](AGO.md) for a non-window function alternative.

**Argument types:**
- `value` — `Any`
- `offset` — `Integer`
- `default` — `Any`


**Return type**: Same type as (`value`)

{% note info %}

Only constant values are accepted for the arguments (`offset`, `default`).

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
- **LAG TOTAL**: `LAG(SUM([Orders]) TOTAL)` ;
- **LAG WITHIN**: `LAG(SUM([Orders]) WITHIN [City])` ;
- **LAG AMONG**: `LAG(SUM([Orders]) AMONG [City])` .


Result

| **City**          | **Category**        | **Order Sum**   | **LAG TOTAL**   | **LAG WITHIN**   | **LAG AMONG**   |
|:------------------|:--------------------|:----------------|:----------------|:-----------------|:----------------|
| `'Detroit'`       | `'Furniture'`       | `7`             | `NULL`          | `NULL`           | `NULL`          |
| `'Detroit'`       | `'Office Supplies'` | `25`            | `7`             | `7`              | `NULL`          |
| `'London'`        | `'Furniture'`       | `1`             | `25`            | `NULL`           | `7`             |
| `'London'`        | `'Office Supplies'` | `10`            | `1`             | `1`              | `25`            |
| `'Moscow'`        | `'Furniture'`       | `2`             | `10`            | `NULL`           | `1`             |
| `'Moscow'`        | `'Office Supplies'` | `4`             | `2`             | `2`              | `10`            |
| `'San Francisco'` | `'Furniture'`       | `5`             | `4`             | `NULL`           | `2`             |
| `'San Francisco'` | `'Office Supplies'` | `23`            | `5`             | `5`              | `4`             |

{% endcut %}

{% cut "Example with the optional argument" %}


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
- **LAG 1**: `LAG(SUM([Orders]), 1)` ;
- **LAG 2**: `LAG(SUM([Orders]), -2)` .


Result

| **City**          | **Order Sum**   | **LAG 1**   | **LAG 2**   |
|:------------------|:----------------|:------------|:------------|
| `'Detroit'`       | `32`            | `NULL`      | `6`         |
| `'London'`        | `11`            | `32`        | `28`        |
| `'Moscow'`        | `6`             | `11`        | `NULL`      |
| `'San Francisco'` | `28`            | `6`         | `NULL`      |

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
- **LAG ORDER BY City**: `LAG(SUM([Orders]) ORDER BY [City] DESC)` ;
- **LAG ORDER BY Order Sum**: `LAG(SUM([Orders]) ORDER BY [Order Sum])` .


Result

| **City**          | **Order Sum**   | **LAG ORDER BY City**   | **LAG ORDER BY Order Sum**   |
|:------------------|:----------------|:------------------------|:-----------------------------|
| `'Detroit'`       | `32`            | `11`                    | `28`                         |
| `'London'`        | `11`            | `6`                     | `6`                          |
| `'Moscow'`        | `6`             | `28`                    | `NULL`                       |
| `'San Francisco'` | `28`            | `NULL`                  | `11`                         |

{% endcut %}


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
