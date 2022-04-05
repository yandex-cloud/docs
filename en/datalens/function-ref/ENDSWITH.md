---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/ENDSWITH.md
---

# ENDSWITH



#### Syntax {#syntax}


```
ENDSWITH( string, substring )
```

#### Description {#description}
Returns `TRUE` if `string` ends in `substring`. For case-insensitive searches, see [IENDSWITH](IENDSWITH.md).

**Argument types:**
- `string` — `Boolean | Date | Datetime | Fractional number | Geopoint | Geopolygon | Integer | String | UUID`
- `substring` — `String`


**Return type**: `Boolean`

#### Examples {#examples}

```
ENDSWITH("Petrov Ivan", "Ivan") = TRUE
```

```
ENDSWITH("Lorem ipsum", "sum") = TRUE
```

```
ENDSWITH("Lorem ipsum", "abc") = FALSE
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Yandex.Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
