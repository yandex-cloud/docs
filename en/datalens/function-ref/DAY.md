---
editable: false
---

# DAY

_Date/Time functions_

#### Syntax {#syntax}


```
DAY( datetime )
```

#### Description {#description}
Returns the number of the day in the month of the specified date `datetime`.

**Argument types:**
- `datetime` — `Date | Datetime`


**Return type**: `Number (whole)`

#### Examples {#examples}

```
DAY(#2019-01-23#) = 23
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
