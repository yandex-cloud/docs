---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/SUM_IF.md
---

# SUM_IF

_Function `SUM_IF` is also found in the following categories: [Window functions](SUM_IF_WINDOW.md)._

#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  SUM_IF( expression, condition )
  ```

- Extended

  ```
  SUM_IF( expression, condition
          [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
          [ BEFORE FILTER BY ... ]
        )
  ```

  More info:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns the sum of all the expression values that meet the `condition` condition. Applicable to numeric data types only.

**Argument types:**
- `expression` — `Fractional number | Integer`
- `condition` — `Boolean`


**Return type**: Same type as (`expression`)

#### Example {#examples}

```
SUM_IF([Profit], [Profit] > 15)
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
