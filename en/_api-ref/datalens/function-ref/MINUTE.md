---
editable: false
---

# MINUTE



#### Syntax {#syntax}


```
MINUTE( datetime )
```

#### Description {#description}
Returns the number of the minute in the hour of the specified date `datetime`. When the date is specified without time, it returns `0`.

**Argument types:**
- `datetime` — `Date | Datetime`


**Return type**: `Number (whole)`

#### Examples {#examples}

```
MINUTE(#2019-01-23 15:07:47#) = 7
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
