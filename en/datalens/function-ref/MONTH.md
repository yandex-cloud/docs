---
editable: false

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# MONTH



#### Syntax {#syntax}


```
MONTH( datetime )
```

#### Description {#description}
Returns the number of the month in the year of the specified date `datetime`.

**Argument types:**
- `datetime` — `Date | Datetime`


**Return type**: `Integer`

#### Examples {#examples}

```
MONTH(#2019-01-23#) = 1
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
