---
editable: false
---

# FIRST (window)



#### Syntax {#syntax}


```
FIRST( value [ TOTAL | WITHIN ... | AMONG ... ] [ ORDER BY ... ] [ BEFORE FILTER BY ... ] )
```

#### Description {#description}

{% note warning %}

The sorting order is based on the fields listed in the sorting section of the chart and in the `ORDER BY` clause. First, `ORDER BY` fields are used, and then they are complemented by the fields from the chart.

{% endnote %}

Returns the value of `value` from the first row in the window. See also [LAST](LAST.md).

**Argument types:**
- `value` — `Any`


**Return type**: Same type as (`value`)

#### Examples {#examples}

```
FIRST(SUM([Sales]) WITHIN [Month] ORDER BY [Date])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
