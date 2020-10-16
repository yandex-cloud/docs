---
editable: false
---

# ICONTAINS

_String functions_

#### Syntax {#syntax}


```
ICONTAINS( string, substring )
```

#### Description {#description}
Case-insensitive version of [CONTAINS](CONTAINS.md). Returns `TRUE` if `string` contains `substring`.

**Argument types:**
- `string` — `Boolean | Date | Datetime | Geopoint | Geopolygon | Number | String | UUID`
- `substring` — `String`


**Return type**: `Boolean`

#### Examples {#examples}

```
ICONTAINS("RU0891923", "ru") = TRUE
```

```
ICONTAINS("Lorem ipsum", "abc") = FALSE
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
