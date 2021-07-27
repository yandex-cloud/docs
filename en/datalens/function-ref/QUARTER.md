---
editable: false

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# QUARTER



#### Syntax {#syntax}


```
QUARTER( datetime )
```

#### Description {#description}
Returns the number of the quarter (from `1` to `4`) of the year of the specified date `datetime`.

**Argument types:**
- `datetime` — `Date | Datetime`


**Return type**: `Integer`

#### Examples {#examples}

```
QUARTER(#2019-01-23#) = 1
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
