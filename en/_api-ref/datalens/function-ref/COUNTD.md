---
editable: false
---

# COUNTD

_Aggregate functions_

#### Syntax {#syntax}


```
COUNTD( value )
```

#### Description {#description}
Returns the number of unique values in the group.

See also [COUNTD_APPROX](COUNTD_APPROX.md).

**Argument types:**
- `value` — `Any`


**Return type**: `Number (whole)`

#### Examples {#examples}

```
COUNTD([ClientID])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
