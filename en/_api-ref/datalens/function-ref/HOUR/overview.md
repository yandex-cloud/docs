---
editable: false
---

# HOUR

_Date/Time functions_

#### Syntax


```
HOUR( datetime )
```

#### Description
Returns the number of the hour in the day of the specified date and time `datetime`. When the date is specified without time, it returns `0`.

**Argument types:**
- `datetime` — `Date | Datetime`


**Return type**: `Number (whole)`

#### Examples

```
HOUR(#2019-01-23 15:07:47#) = 15
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`
