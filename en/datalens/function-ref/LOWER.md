---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/LOWER.md
---

# LOWER



#### Syntax {#syntax}


```
LOWER( string )
```

#### Description {#description}
Returns the string `string` in lowercase.

**Argument types:**
- `string` — `String`


**Return type**: `String`

#### Examples {#examples}

```
LOWER("Lorem ipsum") = "lorem ipsum"
```

```
LOWER("Карл у Клары") = "карл у клары"
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Yandex Documents`, `YDB`.
