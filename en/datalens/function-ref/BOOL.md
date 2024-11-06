---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/BOOL.md
---

# BOOL



#### Syntax {#syntax}


```
BOOL( expression )
```

#### Description {#description}
Converts the `expression` expression to Boolean type according to the following rules:

| Type                                          | `FALSE`             | `TRUE`     |
|:----------------------------------------------|:--------------------|:-----------|
| <code>Fractional number &#124; Integer</code> | `0`, `0.0`          | All others |
| `String`                                      | Empty string (`""`) | All others |
| `Boolean`                                     | `FALSE`             | `TRUE`     |
| <code>Date &#124; Datetime</code>             | -                   | `TRUE`     |

**Argument types:**
- `expression` — `Boolean | Date | Datetime | Fractional number | Geopoint | Geopolygon | Integer | String`


**Return type**: `Boolean`

#### Examples {#examples}

```
BOOL(0) = FALSE
```

```
BOOL(#2019-04-04#) = TRUE
```

```
BOOL("Lorem ipsum") = TRUE
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Yandex Documents`, `YDB`.
