---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/ISTARTSWITH.md
---

# ISTARTSWITH



#### Syntax {#syntax}


```
ISTARTSWITH( string, substring )
```

#### Description {#description}
Case-insensitive version of [STARTSWITH](STARTSWITH.md). Returns `TRUE`  if `string` starts with `substring`.

**Argument types:**
- `string` — `Boolean | Date | Datetime | Fractional number | Geopoint | Geopolygon | Integer | String | UUID`
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

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Yandex Documents`, `YDB`.
