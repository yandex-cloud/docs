---
editable: false
---

# ENDSWITH

_String functions_

#### Syntax


```
ENDSWITH( string, substring )
```

#### Description
Returns `TRUE` if `string` ends in `substring`. For case-insensitive searches, see [IENDSWITH](IENDSWITH.md).

**Argument types:**
- `string` — `String`
- `substring` — `String`


**Return type**: `Boolean`

#### Examples

```
ENDSWITH("Petrov Ivan", "Ivan") = TRUE
```

```
ENDSWITH("Lorem ipsum", "sum") = TRUE
```

```
ENDSWITH("Lorem ipsum", "abc") = FALSE
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Yandex.Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
