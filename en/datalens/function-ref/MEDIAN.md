---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/MEDIAN.md
---

# MEDIAN



#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  MEDIAN( value )
  ```

- Extended

  ```
  MEDIAN( value
          [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
          [ BEFORE FILTER BY ... ]
        )
  ```

  More info:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns the [median](https://en.wikipedia.org/wiki/Median) value. For an even number of items, it returns the greatest of the neighboring items in the central position.

**Argument types:**
- `value` — `Date | Datetime | Fractional number | Integer`


**Return type**: Same type as (`value`)

#### Example {#examples}




Source data

| **City**          | **Category**        | **Orders**   | **Profit**   |
|:------------------|:--------------------|:-------------|:-------------|
| `'London'`        | `'Office Supplies'` | `8`          | `120.10`     |
| `'London'`        | `'Furniture'`       | `1`          | `750.00`     |
| `'Moscow'`        | `'Furniture'`       | `2`          | `1250.50`    |
| `'Moscow'`        | `'Office Supplies'` | `4`          | `85.34`      |
| `'San Francisco'` | `'Office Supplies'` | `23`         | `723.00`     |
| `'Detroit'`       | `'Furniture'`       | `5`          | `6205.87`    |

Formulas:

- **Median Profit**: `MEDIAN([Profit])` .


Result

| **Median Profit**   |
|:--------------------|
| `750.00`            |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.4`, `YDB`.
