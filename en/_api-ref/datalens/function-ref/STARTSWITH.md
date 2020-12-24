---
editable: false
---

# STARTSWITH



#### Syntax {#syntax}


```
STARTSWITH( string, substring )
```

#### Description {#description}
Returns `TRUE` if `string` starts with `substring`. For case-insensitive searches, see [ISTARTSWITH](ISTARTSWITH.md).

**Argument types:**
- `string` — `Boolean | Date | Datetime | Geopoint | Geopolygon | Number | String | UUID`
- `substring` — `String`


**Return type**: `Boolean`

#### Examples {#examples}

```
STARTSWITH("Petrov Ivan", "Petrov") = TRUE
```

```
STARTSWITH("Lorem ipsum", "Lore") = TRUE
```

```
STARTSWITH("Lorem ipsum", "abc") = FALSE
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Yandex.Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
