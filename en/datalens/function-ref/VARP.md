---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/VARP.md
---

# VARP



#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  VARP( value )
  ```

- Extended

  ```
  VARP( value
        [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
        [ BEFORE FILTER BY ... ]
      )
  ```

  More info:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns the statistical variance of all values in an expression across the entire population.

**Argument types:**
- `value` — `Fractional number | Integer`


**Return type**: `Fractional number`

#### Example {#examples}

```
VARP([Profit])
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
