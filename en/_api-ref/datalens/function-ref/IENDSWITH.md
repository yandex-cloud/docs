---
editable: false
---

# IENDSWITH

_String functions_

#### Syntax


```
IENDSWITH( string, substring )
```

#### Description
Case-insensitive version of [ENDSWITH](ENDSWITH.md). Returns `TRUE` if `string` ends in `substring`.

**Argument types:**
- `string` — `String`
- `substring` — `String`


**Return type**: `Boolean`

#### Examples

```
IENDSWITH("PETROV IVAN", "Ivan") = TRUE
```

```
IENDSWITH("Lorem ipsum", "SUM") = TRUE
```

```
IENDSWITH("Lorem ipsum", "abc") = FALSE
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`
