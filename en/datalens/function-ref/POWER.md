---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/POWER.md
---

# POWER



#### Syntax {#syntax}


```
POWER( base, power )
```

#### Description {#description}
Raises `base` to the power of `power`.

**Argument types:**
- `base` — `Fractional number | Integer`
- `power` — `Fractional number | Integer`


**Return type**: `Fractional number`

#### Examples {#examples}

```
POWER(2.3, 4.5) = 42.43998894277659
```

```
POWER(6, 2) = 36.0
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
