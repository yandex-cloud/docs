---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/DAY.md
---

# DAY



#### Syntax {#syntax}


```
DAY( datetime )
```

#### Description {#description}
Returns the number of the day in the month of the specified date `datetime`.

**Argument types:**
- `datetime` — `Date | Datetime`


**Return type**: `Integer`

#### Example {#examples}

```
DAY(#2019-01-23#) = 23
```


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
