---
editable: false
---

# NOW



#### Syntax {#syntax}


```
NOW()
```

#### Description {#description}
Returns the current date and time, depending on the data source and connection type:
- For a direct connection, the function returns the server date and time of the source.
- On materialization, the function returns the UTC+3 date and time.


**Return type**: `Datetime`

#### Example {#examples}

```
NOW() = #2019-01-23 12:53:07#
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
