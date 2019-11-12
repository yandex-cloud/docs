---
editable: false
---

# CONTAINS

_String functions_

#### Syntax


```
CONTAINS( string, substring )
```

#### Description
Returns `TRUE` if `string` contains `substring`. For case-insensitive searches, see [ICONTAINS](../ICONTAINS/overview.md).

**Argument types:**
- `string` — `String`
- `substring` — `String`


**Return type**: `Boolean`

#### Examples

```
CONTAINS("RU0891923", "RU") = TRUE
```

```
CONTAINS("Lorem ipsum", "abc") = FALSE
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`
