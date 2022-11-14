---
editable: false
---

# QUANTILE_APPROX



#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  QUANTILE_APPROX( value, quant )
  ```

- Extended

  ```
  QUANTILE_APPROX( value, quant
                   [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
                   [ BEFORE FILTER BY ... ]
                 )
  ```

  More info:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns the approximate `quant`-level quantile (`quant` should be in range from 0 to 1).

**Argument types:**
- `value` — `Date | Datetime | Fractional number | Integer`
- `quant` — `Fractional number | Integer`


**Return type**: Same type as (`value`)

#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`.
