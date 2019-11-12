---
editable: false
---

# BETWEEN

_Operators_

#### Syntax


```
value [ NOT ] BETWEEEN low AND high
```

#### Description
Returns `TRUE` if `value` is in the range from `low` to `high`.

The option `value NOT BETWEEEN low AND high` returns the opposite value.

**Argument types:**
- `value` — `Any`
- `low` — `Any`
- `high` — `Any`


**Return type**: `Boolean`

#### Examples

```
3 BETWEEN 1 AND 100 = TRUE
```

```
3 NOT BETWEEN 1 AND 100 = FALSE
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Yandex.Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`
