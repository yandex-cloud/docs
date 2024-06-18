---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/COUNT.md
---

# COUNT

_Function `COUNT` is also found in the following categories: [Window functions](COUNT_WINDOW.md)._

#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  COUNT(  [ value ] )
  ```

- Extended

  ```
  COUNT(  [ value ]
         [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
         [ BEFORE FILTER BY ... ]
       )
  ```

  More info:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns the number of items in the group.

Can be used with constants, such as `COUNT(1)` or `COUNT()`. If the chart does not use other measures and dimensions, the result of such an expression will always be `1`. This is because the function does not include any fields, so {{ datalens-short-name }} accesses no source tables in the query.

**Argument types:**
- `value` — `Any`


**Return type**: `Integer`

#### Examples {#examples}

```
COUNT()
```

```
COUNT([OrderID])
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
