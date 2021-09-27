---
editable: false
---

# RANK (window)



#### Syntax {#syntax}


```
RANK( value [ , direction ] [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )
```

#### Description {#description}
Returns the rank of the current row if ordered by the given argument. Rows corresponding to the same value used for sorting have the same rank. If the first two rows both have rank of `1`, then the next row (if it features a different value) will have rank `3`, so, in effect, it is rank with gaps.

If `direction` is `"desc"` or omitted, then ranking is done from greatest to least, if `"asc"`, then from least to greatest.

See also [RANK_DENSE](RANK_DENSE.md), [RANK_UNIQUE](RANK_UNIQUE.md), [RANK_PERCENTILE](RANK_PERCENTILE.md).

**Argument types:**
- `value` — `Boolean | Date | Datetime | Fractional number | Integer | String | UUID`
- `direction` — `String`


**Return type**: `Integer`

{% note info %}

Only constant values are accepted for arguments (`direction`).

{% endnote %}


#### Examples {#examples}

```
RANK([Profit], "asc")
```

```
RANK([Profit] TOTAL)
```

```
RANK([Profit] WITHIN [Country])
```

```
RANK([Profit] AMONG [Date])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
