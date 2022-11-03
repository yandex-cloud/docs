---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/CONTAINS.md
---

# CONTAINS (string)

_Function `CONTAINS` is also found in the following categories: [Array functions](CONTAINS_ARRAY.md)._

#### Syntax {#syntax}


```
CONTAINS( string, substring )
```

#### Description {#description}
Returns `TRUE` if `string` contains `substring`. For case-insensitive searches, see [ICONTAINS](ICONTAINS.md).

**Argument types:**
- `string` — `Boolean | Date | Datetime | Datetime (deprecated) | Fractional number | Geopoint | Geopolygon | Integer | String | UUID`
- `substring` — `String`


**Return type**: `Boolean`

#### Examples {#examples}

```
CONTAINS("RU0891923", "RU") = TRUE
```

```
CONTAINS("Lorem ipsum", "abc") = FALSE
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Yandex.Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
