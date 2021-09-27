---
editable: false
---

# COUNTD



#### Syntax {#syntax}


```
COUNTD( value )
```

#### Description {#description}
Returns the number of unique values in the group.

See also [COUNTD_APPROX](COUNTD_APPROX.md).

**Argument types:**
- `value` — `Any`


**Return type**: `Integer`

#### Examples {#examples}

```
COUNTD([ClientID])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
