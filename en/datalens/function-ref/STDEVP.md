---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/STDEVP.md
---

# STDEVP



#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  STDEVP( value )
  ```

- Extended

  ```
  STDEVP( value
          [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
          [ BEFORE FILTER BY ... ]
        )
  ```

  More info:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns the statistical [standard deviation](https://en.wikipedia.org/wiki/Standard_deviation) of all values in the expression based on the biased population. The function shows how far data points are from their average. In other words, standard deviation shows to what extent values in a dataset deviate from their average.

**Argument types:**
- `value` — `Fractional number | Integer`


**Return type**: `Fractional number`

#### Example {#examples}




Source data

| **Month**     | **Temperature**   |
|:--------------|:------------------|
| `'January'`   | `-8.00`           |
| `'February'`  | `-4.00`           |
| `'March'`     | `-1.00`           |
| `'April'`     | `7.00`            |
| `'May'`       | `14.00`           |
| `'June'`      | `18.00`           |
| `'July'`      | `22.00`           |
| `'August'`    | `19.00`           |
| `'September'` | `13.00`           |
| `'October'`   | `5.00`            |
| `'November'`  | `1.00`            |
| `'December'`  | `-4.00`           |

Formulas:

- **Temperature SD**: `STDEVP([Temperature])` .


Result

| **Temperature SD**   |
|:---------------------|
| `9.77`               |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
