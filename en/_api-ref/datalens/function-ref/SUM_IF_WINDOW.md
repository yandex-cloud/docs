---
editable: false
---

# SUM_IF (window)

_Function `SUM_IF` is also found in the following categories: [Aggregate functions](SUM_IF.md)._

#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  SUM_IF( expression, condition
          TOTAL | WITHIN ... | AMONG ...
        )
  ```

  More info:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)

- Extended

  ```
  SUM_IF( expression, condition
          TOTAL | WITHIN ... | AMONG ...
          [ BEFORE FILTER BY ... ]
        )
  ```

  More info:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)
  - [BEFORE FILTER BY](window-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns the sum of all the expression values that meet the `condition` condition. Applicable to numeric data types only.

**Argument types:**
- `expression` — `Fractional number | Integer`
- `condition` — `Boolean`


**Return type**: Same type as (`expression`)

#### Examples {#examples}

```
SUM_IF([Profit], [Category] = 'Office Supplies' TOTAL)
```

```
SUM_IF([Profit], [Category] = 'Office Supplies' WITHIN [Date])
```

```
SUM_IF([Profit], [Category] = 'Office Supplies' AMONG [Date])
```


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
