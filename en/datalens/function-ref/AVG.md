---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/AVG.md
---

# AVG

_Function `AVG` is also found in the following categories: [Window functions](AVG_WINDOW.md)._

#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  AVG( value )
  ```

- Extended

  ```
  AVG( value
       [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
       [ BEFORE FILTER BY ... ]
     )
  ```

  More info:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns the average of all values. Applicable to numeric data types as well as `Date`.

**Argument types:**
- `value` — `Date | Datetime | Fractional number | Integer`


**Return type**: Depends on argument types

#### Example {#examples}

```
AVG([Profit])
```


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
