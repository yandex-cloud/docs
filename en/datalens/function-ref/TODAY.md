---
editable: false
---

# TODAY



#### Syntax {#syntax}


```
TODAY()
```

#### Description {#description}
Returns the current date, depending on the data source and connection type:
- For a direct connection, the function returns the server date and time of the source.
- On materialization, the function returns the UTC+3 date and time.


**Return type**: `Date`

#### Examples {#examples}

```
TODAY() = #2019-01-23#
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
