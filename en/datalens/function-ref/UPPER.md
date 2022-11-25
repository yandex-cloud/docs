---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/UPPER.md
---

# UPPER



#### Syntax {#syntax}


```
UPPER( string )
```

#### Description {#description}
Returns the string `string` in uppercase.

**Argument types:**
- `string` — `String`


**Return type**: `String`

#### Examples {#examples}

```
UPPER("Lorem ipsum") = "LOREM IPSUM"
```

```
UPPER("Карл у Клары") = "КАРЛ У КЛАРЫ"
```


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
