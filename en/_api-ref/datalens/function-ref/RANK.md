---
editable: false
---

# RANK

_Window functions_

#### Syntax


```
RANK( value [ , direction ] [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )
```

#### Description
Returns the rank of the current row if ordered by the given argument. Rows corresponding to the same value used for sorting have the same rank. If the first two rows both have rank of `1`, then the next row (if it features a different value) will have rank `3`, so, in effect, it is rank with gaps.

See also [RANK_DENSE](RANK_DENSE.md), [RANK_UNIQUE](RANK_UNIQUE.md), [RANK_PERCENTILE](RANK_PERCENTILE.md).

**Argument types:**
- `value` — `Boolean | Date | Datetime | Number | String | UUID`
- `direction` — `String`


**Return type**: `Number (whole)`

{% note info %}

Only constant values are accepted for arguments (direction).

{% endnote %}


#### Examples

```
RANK([Profit])
```

```
RANK([Profit], "desc" TOTAL)
```

```
RANK([Profit] WITHIN [Country])
```

```
RANK([Profit] AMONG [Date])
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
