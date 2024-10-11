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

- **Warmest Day**: `ARG_MAX([Date],[Temperature])` .


Result

| **Warmest Day**   |
|:------------------|
| `2019-03-01`      |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `YDB`.
