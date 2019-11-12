---
editable: false
---

# ISNULL

_Logical functions_

#### Syntax

Version 1:
```
ISNULL( expression )
```
Version 2:
```
expression IS [ NOT ] NULL
```

#### Description
Returns `TRUE` if `expression` is `NULL`, otherwise returns `FALSE`.

`expression IS NOT NULL` returns the opposite result.

**Argument types:**
- `expression` — `Any`


**Return type**: `Boolean`

#### Examples

```
ISNULL([Profit])
```

```
ISNULL("qwerty") = FALSE
```

```
"qwerty" IS NULL = FALSE
```

```
NULL IS NULL = TRUE
```

```
"qwerty" IS NOT NULL = TRUE
```

```
NULL IS NOT NULL = FALSE
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`
