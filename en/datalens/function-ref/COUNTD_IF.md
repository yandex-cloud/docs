---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/COUNTD_IF.md
---

# COUNTD_IF



#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  COUNTD_IF( expression, condition )
  ```

- Extended

  ```
  COUNTD_IF( expression, condition
             [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
             [ BEFORE FILTER BY ... ]
           )
  ```

  More info:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns the number of unique values in the group that meet the `condition` condition.

See also [COUNTD_APPROX](COUNTD_APPROX.md).

**Argument types:**
- `expression` — `Any`
- `condition` — `Boolean`


**Return type**: `Integer`

#### Example {#examples}

```
COUNTD_IF([ClientID], [Profit] > 5)
```


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
