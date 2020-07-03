---
editable: false
---

# YEAR

_Date/Time functions_

#### Syntax {#syntax}


```
YEAR( datetime )
```

#### Description {#description}
Returns the year number in the specified date `datetime`.

**Argument types:**
- `datetime` — `Date | Datetime`


**Return type**: `Number (whole)`

#### Examples {#examples}

```
YEAR(#2019-01-23#) = 2019
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
