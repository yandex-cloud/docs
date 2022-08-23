---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/MONTH.md
---

# MONTH



#### Syntax {#syntax}


```
MONTH( datetime )
```

#### Description {#description}
Returns the number of the month in the year of the specified date `datetime`.

**Argument types:**
- `datetime` — `Date | Datetime | Datetime (deprecated)`


**Return type**: `Integer`

#### Example {#examples}

```
MONTH(#2019-01-23#) = 1
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
