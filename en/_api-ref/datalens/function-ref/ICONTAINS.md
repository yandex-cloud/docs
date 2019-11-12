---
editable: false
---

# ICONTAINS

_String functions_

#### Syntax


```
ICONTAINS( string, substring )
```

#### Description
Case-insensitive version of [CONTAINS](CONTAINS.md). Returns `TRUE` if `string` contains `substring`.

**Argument types:**
- `string` — `String`
- `substring` — `String`


**Return type**: `Boolean`

#### Examples

```
ICONTAINS("RU0891923", "ru") = TRUE
```

```
ICONTAINS("Lorem ipsum", "abc") = FALSE
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`
