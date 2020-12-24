---
editable: false
---

# IF



#### Syntax {#syntax}

Version 1:
```
IF condition_1
    THEN result_1
[ ELSEIF condition_2
    THEN result_2
  ... ]
ELSE
    default_result
END
```
Version 2:
```
IF(
    condition_1, result_1,
  [ condition_2, result_2,
    ... ]
    default_result
)
```

#### Description {#description}
Checks conditional expressions `condition_1`, `result_1`, ... and returns the matching result for the first condition found to be `TRUE`. IF all conditional expressions are `FALSE`, it returns `default_result`.

**Argument types:**
- `condition_1` — `Any`
- `result_1` — `Any`
- `condition_2` — `Any`
- `result_2` — `Any`
- `default_result` — `Any`


**Return type**: Depends on argument types

#### Examples {#examples}

```
IF("Hello world" LIKE "%el%", "is like", "is not like") = "is like"
```

```
IF
    [Profit] > 100
        THEN "High"
    ELSEIF [Profit] > 25
        THEN "Medium"
    ELSE "Low"
END
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
