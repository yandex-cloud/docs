---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/FIRST.md
---

# FIRST (window)



#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  FIRST( value )
  ```

- Extended

  ```
  FIRST( value
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

Returns the value of `value` from the first row in the window. See also [LAST](LAST.md).

**Argument types:**
- `value` — `Any`


**Return type**: Same type as (`value`)

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
- **FIRST TOTAL**: `FIRST(SUM([Orders]) TOTAL)` ;
- **FIRST WITHIN**: `FIRST(SUM([Orders]) WITHIN [City])` ;
- **FIRST AMONG**: `FIRST(SUM([Orders]) AMONG [City])` .


Result

| **City**          | **Category**        | **Order Sum**   | **FIRST TOTAL**   | **FIRST WITHIN**   | **FIRST AMONG**   |
|:------------------|:--------------------|:----------------|:------------------|:-------------------|:------------------|
| `'Detroit'`       | `'Furniture'`       | `7`             | `7`               | `7`                | `7`               |
| `'Detroit'`       | `'Office Supplies'` | `25`            | `7`               | `7`                | `25`              |
| `'London'`        | `'Furniture'`       | `1`             | `7`               | `1`                | `7`               |
| `'London'`        | `'Office Supplies'` | `10`            | `7`               | `1`                | `25`              |
| `'Moscow'`        | `'Furniture'`       | `2`             | `7`               | `2`                | `7`               |
| `'Moscow'`        | `'Office Supplies'` | `4`             | `7`               | `2`                | `25`              |
| `'San Francisco'` | `'Furniture'`       | `5`             | `7`               | `5`                | `7`               |
| `'San Francisco'` | `'Office Supplies'` | `23`            | `7`               | `5`                | `25`              |

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
- **FIRST ORDER BY City**: `FIRST(SUM([Orders]) ORDER BY [City] DESC)` ;
- **FIRST ORDER BY Order Sum**: `FIRST(SUM([Orders]) ORDER BY [Order Sum])` .


Result

| **City**          | **Order Sum**   | **FIRST ORDER BY City**   | **FIRST ORDER BY Order Sum**   |
|:------------------|:----------------|:--------------------------|:-------------------------------|
| `'Detroit'`       | `32`            | `28`                      | `6`                            |
| `'London'`        | `11`            | `28`                      | `6`                            |
| `'Moscow'`        | `6`             | `28`                      | `6`                            |
| `'San Francisco'` | `28`            | `28`                      | `6`                            |

{% endcut %}


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Yandex Documents`.
