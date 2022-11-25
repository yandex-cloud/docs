---
editable: false
---

# SECOND



#### Syntax {#syntax}


```
SECOND( datetime )
```

#### Description {#description}
Returns the number of the second in the minute of the specified date `datetime`. When the date is specified without time, it returns `0`.

**Argument types:**
- `datetime` — `Date | Datetime`


**Return type**: `Integer`

#### Example {#examples}

```
SECOND(#2019-01-23 15:07:47#) = 47
```


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
