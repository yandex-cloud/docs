---
editable: false
---

# SECOND

_Date/Time functions_

#### Syntax


```
SECOND( datetime )
```

#### Description
Returns the number of the second in the minute of the specified date `datetime`. When the date is specified without time, it returns `0`.

**Argument types:**
- `datetime` — `Date | Datetime`


**Return type**: `Number (whole)`

#### Examples

```
SECOND(#2019-01-23 15:07:47#) = 47
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
