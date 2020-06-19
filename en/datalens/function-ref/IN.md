---
editable: false
---

# IN

_Operators_

#### Syntax


```
item [ NOT ] IN (<list>)
```

#### Description
Checks whether the value matches at least one of the values listed in `IN(...)`.

The option `item NOT IN (<`list`>)` returns the opposite value.

**Argument types:**
- `item` — `Any`
- `list` — `Any`


**Return type**: `Boolean`

#### Examples

```
3 IN (23, 5, 3, 67) = TRUE
```

```
3 NOT IN (23, 5, 3, 67) = FALSE
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Yandex.Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
