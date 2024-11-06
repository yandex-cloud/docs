---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/MINUTE.md
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


**Return type**: `Integer`

#### Example {#examples}

```
MINUTE(#2019-01-23 15:07:47#) = 7
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Yandex Documents`, `YDB`.
