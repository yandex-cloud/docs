---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/WEEK.md
---

# WEEK



#### Syntax {#syntax}


```
WEEK( value )
```

#### Description {#description}
The number of the week according to [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601). The first week is the week that contains the first Thursday of the year or January 4th.

**Argument types:**
- `value` — `Date | Datetime`


**Return type**: `Integer`

#### Example {#examples}

```
WEEK(#1971-01-14 01:02:03#) = 2
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
