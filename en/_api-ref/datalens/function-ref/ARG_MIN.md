---
editable: false
---

# ARG_MIN



#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  ARG_MIN( value, comp )
  ```

- Extended

  ```
  ARG_MIN( value, comp
           [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
           [ BEFORE FILTER BY ... ]
         )
  ```

  More info:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns `value` for the minimum value of `comp` in the group. If multiple values of `value` match the minimum value of `comp`, then the first one encountered is returned. This makes the function non-deterministic.

**Argument types:**
- `value` — `Any`
- `comp` — `Any`


**Return type**: Same type as (`value`)

#### Example {#examples}

```
ARG_MIN([Sales], [Profit])
```


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `YDB`.
