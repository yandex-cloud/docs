---
editable: false
---

# STDEVP



#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  STDEVP( value )
  ```

- Extended

  ```
  STDEVP( value
          [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
          [ BEFORE FILTER BY ... ]
        )
  ```

  More info:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns the statistical standard deviation of all values in the expression based on the biased population.

**Argument types:**
- `value` — `Fractional number | Integer`


**Return type**: `Fractional number`

#### Example {#examples}

```
STDEVP([Profit])
```


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
