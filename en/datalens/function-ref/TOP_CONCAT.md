---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/TOP_CONCAT.md
---

# TOP_CONCAT



#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  TOP_CONCAT( expression, amount [ , separator ] )
  ```

- Extended

  ```
  TOP_CONCAT( expression, amount [ , separator ]
              [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
              [ BEFORE FILTER BY ... ]
            )
  ```

  More info:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns a string that contains top `amount` unique values of `expression` delimited by `separator` (if `separator` is not specified, a comma is used).

**Argument types:**
- `expression` — `Array of fractional numbers | Array of integers | Array of strings | Boolean | Date | Datetime | Fractional number | Geopoint | Geopolygon | Integer | String | UUID`
- `amount` — `Integer`
- `separator` — `String`


**Return type**: `String`

{% note info %}

Only constant values are accepted for the arguments (`amount`, `separator`).

{% endnote %}


#### Examples {#examples}

```
TOP_CONCAT([Profit], 3)
```

```
TOP_CONCAT([Profit], 3, '; ')
```


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `YDB`.
