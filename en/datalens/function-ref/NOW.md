---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/NOW.md
---

# NOW



#### Syntax {#syntax}


```
NOW()
```

#### Description {#description}
Returns the current date and time, depending on the data source and connection type.

**Return type**: `Datetime`

{% note info %}

On `YQL`, the function always returns the UTC date and time.

{% endnote %}


#### Example {#examples}

```
NOW() = #2019-01-23 12:53:07#
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
