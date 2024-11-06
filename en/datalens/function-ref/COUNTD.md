---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/COUNTD.md
---

# COUNTD



#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  COUNTD( value )
  ```

- Extended

  ```
  COUNTD( value
          [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
          [ BEFORE FILTER BY ... ]
        )
  ```

  More info:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns the number of unique values in the group.

See also [COUNTD_APPROX](COUNTD_APPROX.md).

**Argument types:**
- `value` — `Any`


**Return type**: `Integer`

#### Example {#examples}

```
COUNTD([ClientID])
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Yandex Documents`, `YDB`.
