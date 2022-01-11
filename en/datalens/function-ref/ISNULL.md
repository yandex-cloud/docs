---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/ISNULL.md
---


# ISNULL



#### Syntax {#syntax}

Version 1:
```
ISNULL( expression )
```
Version 2:
```
expression IS [ NOT ] NULL
```

#### Description {#description}
Returns `TRUE` if `expression` is `NULL`, otherwise returns `FALSE`.

`expression IS NOT NULL` returns the opposite result.

**Argument types:**
- `expression` — `Any`


**Return type**: `Boolean`

#### Examples {#examples}

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


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
