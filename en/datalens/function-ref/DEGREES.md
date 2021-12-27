---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/DEGREES.md
---


# DEGREES



#### Syntax {#syntax}


```
DEGREES( radians )
```

#### Description {#description}
Converts radians to degrees.

**Argument types:**
- `radians` — `Fractional number | Integer`


**Return type**: `Fractional number`

#### Examples {#examples}

```
DEGREES(0) = 0.0
```

```
DEGREES(PI()) = 180.0
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
