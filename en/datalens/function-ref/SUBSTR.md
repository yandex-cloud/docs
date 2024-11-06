---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/SUBSTR.md
---

# SUBSTR



#### Syntax {#syntax}


```
SUBSTR( string, from_index [ , length ] )
```

#### Description {#description}
Returns the substring `string` starting from the index `from_index`. The numbering starts with one.

If an additional argument `length` is specified, a substring of the specified length is returned.

**Argument types:**
- `string` — `String`
- `from_index` — `Integer`
- `length` — `Integer`


**Return type**: `String`

#### Examples {#examples}

```
SUBSTR("Computer", 3) = "mputer"
```

```
SUBSTR("Computer", 3, 2) = "mp"
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Yandex Documents`, `YDB`.
