---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/AVG_IF_WINDOW.md
---

# AVG_IF (window)

_Function `AVG_IF` is also found in the following categories: [Aggregate functions](AVG_IF.md)._

#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  AVG_IF( expression, condition
          TOTAL | WITHIN ... | AMONG ...
        )
  ```

  More info:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)

- Extended

  ```
  AVG_IF( expression, condition
          TOTAL | WITHIN ... | AMONG ...
          [ BEFORE FILTER BY ... ]
        )
  ```

  More info:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)
  - [BEFORE FILTER BY](window-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns the average of all values that meet the `condition` condition. If the values don't exist, it returns `NULL`. Applicable to numeric data types only.

**Argument types:**
- `expression` — `Fractional number | Integer`
- `condition` — `Boolean`


**Return type**: Same type as (`expression`)

#### Examples {#examples}

```
AVG_IF([Profit], [Category] = 'Office Supplies' TOTAL)
```

```
AVG_IF([Profit], [Category] = 'Office Supplies' WITHIN [Date])
```

```
AVG_IF([Profit], [Category] = 'Office Supplies' AMONG [Date])
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
