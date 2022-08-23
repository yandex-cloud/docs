---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/HOUR.md
---

# HOUR



#### Syntax {#syntax}


```
HOUR( datetime )
```

#### Description {#description}
Returns the number of the hour in the day of the specified date and time `datetime`. When the date is specified without time, it returns `0`.

**Argument types:**
- `datetime` — `Date | Datetime | Datetime (deprecated)`


**Return type**: `Integer`

#### Example {#examples}

```
HOUR(#2019-01-23 15:07:47#) = 15
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
