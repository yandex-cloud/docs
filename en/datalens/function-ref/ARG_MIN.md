---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/ARG_MIN.md
---

# ARG_MIN



#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  ARG_MIN( value, expression_to_minimize )
  ```

- Extended

  ```
  ARG_MIN( value, expression_to_minimize
           [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
           [ BEFORE FILTER BY ... ]
         )
  ```

  More info:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns `value` for the minimum value of `expression_to_minimize` in the group. If multiple values of `value` match the minimum value of `expression_to_minimize`, then the first one encountered is returned. This makes the function non-deterministic.

**Argument types:**
- `value` — `Any`
- `expression_to_minimize` — `Any`


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

- **Coldest Month**: `ARG_MIN([Month],[Temperature])` .


Result

| **Coldest Month**   |
|:--------------------|
| `'January'`         |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `YDB`.
