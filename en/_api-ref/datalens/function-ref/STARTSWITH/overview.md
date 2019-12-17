---
editable: false
---

# STARTSWITH

_String functions_

#### Syntax


```
STARTSWITH( string, substring )
```

#### Description
Returns `TRUE` if `string` starts with `substring`. For case-insensitive searches, see [ISTARTSWITH](../ISTARTSWITH/overview.md).

**Argument types:**
- `string` — `String`
- `substring` — `String`


**Return type**: `Boolean`

#### Examples

```
STARTSWITH("Petrov Ivan", "Petrov") = TRUE
```

```
STARTSWITH("Lorem ipsum", "Lore") = TRUE
```

```
STARTSWITH("Lorem ipsum", "abc") = FALSE
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
