---
editable: false
---

# MD5



#### Syntax {#syntax}


```
MD5( value )
```

#### Description {#description}
Returns the MD5 hash of `value` as a hexadecimal string.

**Argument types:**
- `value` — `String`


**Return type**: `String`

#### Example {#examples}

```
MD5("DataLens") = "C1FD5D9E4189FB89C1021A72F7E06C00"
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Trino`, `YDB`.
