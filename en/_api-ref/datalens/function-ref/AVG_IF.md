---
editable: false
---

# AVG_IF

_Function `AVG_IF` is also found in the following categories: [Window functions](AVG_IF_WINDOW.md)._

#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  AVG_IF( expression, condition )
  ```

- Extended

  ```
  AVG_IF( expression, condition
          [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
          [ BEFORE FILTER BY ... ]
        )
  ```

  More info:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns the average of all values that meet the `condition` condition. If the values don't exist, it returns `NULL`. Applicable to numeric data types only.

**Argument types:**
- `expression` — `Fractional number | Integer`
- `condition` — `Boolean`


**Return type**: `Fractional number`

#### Example {#examples}

```
AVG_IF([Profit], [Profit] > 5)
```


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
