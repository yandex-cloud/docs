---
editable: false
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

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
