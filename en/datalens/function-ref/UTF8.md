---
editable: false
---

# UTF8

_String functions_

#### Syntax


```
UTF8( string, old_encoding )
```

#### Description
Converts the `string` string encoding to `UTF8`.

**Argument types:**
- `string` — `String`
- `old_encoding` — `String`


**Return type**: `String`

#### Examples

```
UTF8([Name], "CP-1251")
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`.
