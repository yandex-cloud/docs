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

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Yandex Documents`, `YDB`.
