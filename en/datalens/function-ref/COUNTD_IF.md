---
editable: false
---

# COUNTD_IF



#### Syntax {#syntax}


```
COUNTD_IF( expression, condition )
```

#### Description {#description}
Returns the number of unique values in the group that meet the `condition` condition.

See also [COUNTD_APPROX](COUNTD_APPROX.md).

**Argument types:**
- `expression` — `Any`
- `condition` — `Boolean`


**Return type**: `Integer`

#### Example {#examples}

```
COUNTD_IF([ClientID], [Profit] > 5)
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
