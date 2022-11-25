---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/RADIANS.md
---

# RADIANS



#### Syntax {#syntax}


```
RADIANS( degrees )
```

#### Description {#description}
Converts `degrees` degrees to radians.

**Argument types:**
- `degrees` — `Fractional number | Integer`


**Return type**: `Fractional number`

#### Examples {#examples}

```
RADIANS(0) = 0.0
```

```
RADIANS(180) = 3.14159
```


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
