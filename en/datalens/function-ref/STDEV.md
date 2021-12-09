---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/STDEV.md
---


# STDEV



#### Syntax {#syntax}


```
STDEV( value )
```

#### Description {#description}
Returns the statistical standard deviation of all values in the expression based on a selection from the population.

**Argument types:**
- `value` — `Fractional number | Integer`


**Return type**: `Fractional number`

#### Example {#examples}

```
STDEV([Profit])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
