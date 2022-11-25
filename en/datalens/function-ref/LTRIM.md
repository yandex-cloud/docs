---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/LTRIM.md
---

# LTRIM



#### Syntax {#syntax}


```
LTRIM( string )
```

#### Description {#description}
Returns the string `string` without spaces at the beginning of the string.

**Argument types:**
- `string` — `String`


**Return type**: `String`

#### Example {#examples}

```
LTRIM(" Computer") = "Computer"
```


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
