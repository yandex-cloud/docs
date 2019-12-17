---
editable: false
---

# ISTARTSWITH

_String functions_

#### Syntax


```
ISTARTSWITH( string, substring )
```

#### Description
Case-insensitive version of [STARTSWITH](../STARTSWITH/overview.md). Returns `TRUE`  if `string` starts with `substring`.

**Argument types:**
- `string` — `String`
- `substring` — `String`


**Return type**: `Boolean`

#### Examples

```
ISTARTSWITH("petrov ivan", "Petrov") = TRUE
```

```
ISTARTSWITH("Lorem ipsum", "LORE") = TRUE
```

```
ISTARTSWITH("Lorem ipsum", "abc") = FALSE
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
