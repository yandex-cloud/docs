---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/COUNT_IF.md
---

# COUNT_IF

_Function `COUNT_IF` is also found in the following categories: [Window functions](COUNT_IF_WINDOW.md)._

#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  COUNT_IF( condition )
  ```

- Extended

  ```
  COUNT_IF( condition
            [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
            [ BEFORE FILTER BY ... ]
          )
  ```

  More info:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns the number of items in the group meeting the `condition` condition.

**Argument types:**
- `condition` — `Boolean`


**Return type**: `Integer`

#### Example {#examples}

```
COUNT_IF([Profit] > 5)
```


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
