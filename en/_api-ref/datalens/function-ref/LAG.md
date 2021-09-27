---
editable: false
---

# LAG (window)



#### Syntax {#syntax}


```
LAG( value [ , offset [ , default ] ] [ TOTAL | WITHIN ... | AMONG ... ] [ ORDER BY ... ] [ BEFORE FILTER BY ... ] )
```

#### Description {#description}

{% note warning %}

The sorting order is based on the fields listed in the sorting section of the chart and in the `ORDER BY` clause. First, `ORDER BY` fields are used, and then they are complemented by the fields from the chart.

{% endnote %}

Returns `value` re-evaluated against the row that is offset from the current row by `offset` within the specified window:
- Positive `offset` seeks among preceding rows.
- Negative `offset` seeks among following rows.

By default `offset` is `1`.

If there is no available value (`offset` reaches before the first row or after the last one), then `default` is returned. If `default` is not specified, then `NULL` is used.

See also [AGO](AGO.md) for a non-window function alternative.

**Argument types:**
- `value` — `Any`
- `offset` — `Integer`
- `default` — `Any`


**Return type**: Same type as (`value`)

{% note info %}

Only constant values are accepted for arguments (`offset`, `default`).

{% endnote %}


#### Examples {#examples}

```
LAG([Profit], 2)
```

```
LAG([Profit], 7 AMONG [Date] ORDER BY [Date])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
