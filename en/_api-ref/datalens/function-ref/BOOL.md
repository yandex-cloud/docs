---
editable: false
---

# BOOL

_Type conversion functions_

#### Syntax


```
BOOL( expression )
```

#### Description
Converts the `expression` expression to Boolean type according to the following rules:

| Type                              | `FALSE`             | `TRUE`     |
|:----------------------------------|:--------------------|:-----------|
| `Number`                          | `0`, `0.0`          | All others |
| `String`                          | Empty string (`""`) | All others |
| `Boolean`                         | `FALSE`             | `TRUE`     |
| <code>Date &#124; Datetime</code> | -                   | `TRUE`     |

**Argument types:**
- `expression` — `Boolean | Date | Datetime | Geopoint | Geopolygon | Number | String`


**Return type**: `Boolean`

#### Examples

```
BOOL(0) = FALSE
```

```
BOOL(#2019-04-04#) = TRUE
```

```
BOOL("Lorem ipsum") = TRUE
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
