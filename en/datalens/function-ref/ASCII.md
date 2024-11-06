---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/ASCII.md
---

# ASCII



#### Syntax {#syntax}


```
ASCII( string )
```

#### Description {#description}
Returns the numeric representation of the first character of the string.

**Argument types:**
- `string` — `String`


**Return type**: `Integer`

#### Examples {#examples}

```
ASCII("N") = 78
```

```
ASCII("¹") = 185
```

```
ASCII("¹") = 194
```

```
ASCII("…") = 8230
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Yandex Documents`, `YDB`.
