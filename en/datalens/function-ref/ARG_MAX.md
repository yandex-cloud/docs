---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/ARG_MAX.md
---

# ARG_MAX



#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  ARG_MAX( value, expression_to_maximize )
  ```

- Extended

  ```
  ARG_MAX( value, expression_to_maximize
           [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
           [ BEFORE FILTER BY ... ]
         )
  ```

  More info:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns `value` for the maximum value of `expression_to_maximize` in the group. If multiple values of `value` match the maximum value of `expression_to_maximize`, then the first one encountered is returned. This makes the function non-deterministic.

**Argument types:**
- `value` — `Any`
- `expression_to_maximize` — `Any`


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

- **Warmest Month**: `ARG_MAX([Month],[Temperature])` .


Result

| **Warmest Month**   |
|:--------------------|
| `'July'`            |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `YDB`.
