---
editable: false
---

# STR

_Type conversion functions_

#### Syntax


```
STR( expression )
```

#### Description
Converts the `expression` expression to string type.

**Argument types:**
- `expression` — `Any`


**Return type**: `String`

#### Examples

```
STR(77) = "77"
```

```
STR(1 != 1) = "False"
```

```
STR(#2019-01-01#) = "2019-01-01"
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`
