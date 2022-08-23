---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/ALL_CONCAT.md
---

# ALL_CONCAT



#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  ALL_CONCAT( expression [ , separator ] )
  ```

- Extended

  ```
  ALL_CONCAT( expression [ , separator ]
              [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
              [ BEFORE FILTER BY ... ]
            )
  ```

  More info:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns a string that contains all grouped values of `expression` delimited by `separator` (if `separator` is not specified, a comma is used).

**Argument types:**
- `expression` — `Array of fractional numbers | Array of integers | Array of strings | Boolean | Date | Datetime | Datetime (deprecated) | Fractional number | Geopoint | Geopolygon | Integer | String | UUID`
- `separator` — `String`


**Return type**: `String`

{% note info %}

Only constant values are accepted for the arguments (`separator`).

{% endnote %}


#### Examples {#examples}

```
ALL_CONCAT([Profit])
```

```
ALL_CONCAT([Profit], '; ')
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `PostgreSQL 9.3`, `YDB`.
