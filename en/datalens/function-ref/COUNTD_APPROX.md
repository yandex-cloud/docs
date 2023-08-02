---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/COUNTD_APPROX.md
---

# COUNTD_APPROX



#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  COUNTD_APPROX( value )
  ```

- Extended

  ```
  COUNTD_APPROX( value
                 [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
                 [ BEFORE FILTER BY ... ]
               )
  ```

  More info:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns the approximate number of unique values in the group. Faster than [COUNTD](COUNTD.md), but doesn't guarantee accuracy.

**Argument types:**
- `value` — `Any`


**Return type**: `Integer`

#### Example {#examples}

```
COUNTD_APPROX([ClienID])
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Oracle Database 12c (12.1)`, `YDB`.
