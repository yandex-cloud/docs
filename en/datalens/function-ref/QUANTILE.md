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

| **Date**     | **Temperature**   |
|:-------------|:------------------|
| `2019-03-01` | `5.00`            |
| `2019-03-02` | `0.00`            |
| `2019-03-03` | `-3.00`           |
| `2019-03-04` | `1.00`            |
| `2019-03-05` | `4.00`            |
| `2019-03-06` | `5.00`            |
| `2019-03-07` | `1.00`            |
| `2019-03-08` | `-6.00`           |
| `2019-03-09` | `-6.00`           |
| `2019-03-10` | `-4.00`           |
| `2019-03-11` | `-2.00`           |
| `2019-03-12` | `0.00`            |

Formulas:

- **0.25 quantile**: `QUANTILE([Temperature], 0.25)` ;
- **0.5 quantile**: `QUANTILE([Temperature], 0.5)` ;
- **0.75 quantile**: `QUANTILE([Temperature], 0.75)` .


Result

| **0.25 quantile**   | **0.5 quantile**   | **0.75 quantile**   |
|:--------------------|:-------------------|:--------------------|
| `-3.00`             | `0.00`             | `4.00`              |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.4`, `Yandex Documents`, `YDB`.
