---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/STARTSWITH.md
---

# STARTSWITH (string)

_Function `STARTSWITH` is also found in the following categories: [Array functions](STARTSWITH_ARRAY.md)._

#### Syntax {#syntax}


```
STARTSWITH( string, substring )
```

#### Description {#description}
Returns `TRUE` if `string` starts with `substring`. For case-insensitive searches, see [ISTARTSWITH](ISTARTSWITH.md).

**Argument types:**
- `string` — `Boolean | Date | Datetime | Fractional number | Geopoint | Geopolygon | Integer | String | UUID`
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

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Yandex Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Yandex Documents`, `YDB`.
