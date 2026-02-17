---
editable: false
---

# SHA1



#### Syntax {#syntax}


```
SHA1( value )
```

#### Description {#description}
Returns the SHA-1 hash of `value` as a hexadecimal string.

**Argument types:**
- `value` — `String`


**Return type**: `String`

#### Example {#examples}

```
SHA1("DataLens") = "F4EA6F8285E57FC18D8CA03672703B52C302231A"
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Trino`, `YDB`.
