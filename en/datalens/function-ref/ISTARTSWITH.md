---
editable: false
---

# ISTARTSWITH

_String functions_

#### Syntax {#syntax}


```
ISTARTSWITH( string, substring )
```

#### Description {#description}
Case-insensitive version of [STARTSWITH](STARTSWITH.md). Returns `TRUE`  if `string` starts with `substring`.

**Argument types:**
- `string` — `Boolean | Date | Datetime | Geopoint | Geopolygon | Number | String | UUID`
- `substring` — `String`


**Return type**: `Boolean`

#### Examples {#examples}

```
ISTARTSWITH("petrov ivan", "Petrov") = TRUE
```

```
ISTARTSWITH("Lorem ipsum", "LORE") = TRUE
```

```
ISTARTSWITH("Lorem ipsum", "abc") = FALSE
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
