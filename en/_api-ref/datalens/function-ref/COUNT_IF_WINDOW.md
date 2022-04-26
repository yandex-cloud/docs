---
editable: false
---

# COUNT_IF (window)

_Function `COUNT_IF` is also found in the following categories: [Aggregate functions](COUNT_IF.md)._

#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  COUNT_IF( expression, condition
            TOTAL | WITHIN ... | AMONG ...
          )
  ```

- Extended

  ```
  COUNT_IF( expression, condition
            TOTAL | WITHIN ... | AMONG ...
            [ BEFORE FILTER BY ... ]
          )
  ```

{% endlist %}

#### Description {#description}
Returns the number of items in the specified window meeting the `expression` condition.

**Argument types:**
- `expression` — `Fractional number | Integer`
- `condition` — `Boolean`


**Return type**: Same type as (`expression`)

#### Examples {#examples}

```
COUNT_IF([Profit], [Category] = 'Office Supplies' TOTAL)
```

```
COUNT_IF([Profit], [Category] = 'Office Supplies' WITHIN [Date])
```

```
COUNT_IF([Profit], [Category] = 'Office Supplies' AMONG [Date])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
