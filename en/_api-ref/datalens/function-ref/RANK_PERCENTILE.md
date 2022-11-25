---
editable: false
---

# RANK_PERCENTILE (window)



#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  RANK_PERCENTILE( value [ , direction ] )
  ```

- Extended

  ```
  RANK_PERCENTILE( value [ , direction ]
                   [ TOTAL | WITHIN ... | AMONG ... ]
                   [ BEFORE FILTER BY ... ]
                 )
  ```

  More info:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)
  - [BEFORE FILTER BY](window-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns the relative rank (from `0` to `1`) of the current row if ordered by the given argument. Calculated as `(RANK(...) - 1) / (row count) `.

If `direction` is `"desc"` or omitted, then ranking is done from greatest to least, if `"asc"`, then from least to greatest.

See also [RANK](RANK.md), [RANK_DENSE](RANK_DENSE.md), [RANK_UNIQUE](RANK_UNIQUE.md).

**Argument types:**
- `value` — `Boolean | Date | Datetime | Fractional number | Integer | String | UUID`
- `direction` — `String`


**Return type**: `Fractional number`

{% note info %}

Only constant values are accepted for the arguments (`direction`).

{% endnote %}


#### Examples {#examples}

{% cut "Example with two arguments" %}


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

| **[City]**        | **SUM([Orders])**   | **RANK_PERCENTILE(SUM([Orders]), "desc")**   | **RANK_PERCENTILE(SUM([Orders]), "asc")**   |
|:------------------|:--------------------|:---------------------------------------------|:--------------------------------------------|
| `'Detroit'`       | `32`                | `0.00`                                       | `1.00`                                      |
| `'London'`        | `11`                | `0.67`                                       | `0.33`                                      |
| `'Moscow'`        | `6`                 | `1.00`                                       | `0.00`                                      |
| `'San Francisco'` | `28`                | `0.33`                                       | `0.67`                                      |

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

| **[City]**        | **[Category]**      | **SUM([Orders])**   | **RANK_PERCENTILE(SUM([Orders]) TOTAL)**   | **RANK_PERCENTILE(SUM([Orders]) WITHIN [City])**   | **RANK_PERCENTILE(SUM([Orders]) AMONG [City])**   |
|:------------------|:--------------------|:--------------------|:-------------------------------------------|:---------------------------------------------------|:--------------------------------------------------|
| `'Detroit'`       | `'Furniture'`       | `7`                 | `0.43`                                     | `1.00`                                             | `0.00`                                            |
| `'Detroit'`       | `'Office Supplies'` | `25`                | `0.00`                                     | `0.00`                                             | `0.00`                                            |
| `'London'`        | `'Furniture'`       | `1`                 | `1.00`                                     | `1.00`                                             | `1.00`                                            |
| `'London'`        | `'Office Supplies'` | `10`                | `0.29`                                     | `0.00`                                             | `0.67`                                            |
| `'Moscow'`        | `'Furniture'`       | `2`                 | `0.86`                                     | `1.00`                                             | `0.67`                                            |
| `'Moscow'`        | `'Office Supplies'` | `4`                 | `0.71`                                     | `0.00`                                             | `1.00`                                            |
| `'San Francisco'` | `'Furniture'`       | `5`                 | `0.57`                                     | `1.00`                                             | `0.33`                                            |
| `'San Francisco'` | `'Office Supplies'` | `23`                | `0.14`                                     | `0.00`                                             | `0.33`                                            |

{% endcut %}


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
