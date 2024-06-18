---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/QUANTILE.md
---

# QUANTILE



#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  QUANTILE( value, quant )
  ```

- Extended

  ```
  QUANTILE( value, quant
            [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
            [ BEFORE FILTER BY ... ]
          )
  ```

  More info:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns the precise `quant`-level quantile (`quant` should be in range from 0 to 1).

**Argument types:**
- `value` — `Date | Datetime | Fractional number | Integer`
- `quant` — `Fractional number | Integer`


**Return type**: Same type as (`value`)

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

- **0.25 quantile**: `QUANTILE([Temperature], 0.25)` ;
- **0.5 quantile**: `QUANTILE([Temperature], 0.5)` ;
- **0.75 quantile**: `QUANTILE([Temperature], 0.75)` .


Result

| **0.25 quantile**   | **0.5 quantile**   | **0.75 quantile**   |
|:--------------------|:-------------------|:--------------------|
| `-1.00`             | `7.00`             | `18.00`             |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.4`, `YDB`.
