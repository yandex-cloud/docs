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
Returns the substring `string` starting from the index `from_index`.

If an additional argument `length` is specified, a substring of the specified length is returned.

**Argument types:**
- `string` — `String`
- `from_index` — `Integer`
- `length` — `Integer`


**Return type**: `String`

#### Example {#examples}

```
SUBSTR("Computer", 3) = "mputer"
```


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
