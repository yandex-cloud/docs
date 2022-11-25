---
editable: false
---

# TODAY



#### Syntax {#syntax}


```
TODAY()
```

#### Description {#description}
Returns the current date, depending on the data source and connection type.

**Return type**: `Date`

{% note info %}

On materialization, the function returns the UTC+3 date and time.

{% endnote %}


#### Example {#examples}

```
TODAY() = #2019-01-23#
```


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
