---
editable: false
---

# CONCAT

_String functions_

#### Syntax


```
CONCAT( arg_1, arg_2, arg_3 [ , ... ] )
```

#### Description
Merges any number of strings. When non-string types are used, they're converted to strings and then merged.

**Argument types:**
- `arg_1` — `Any`
- `arg_2` — `Any`
- `arg_3` — `Any`


**Return type**: `String`

#### Examples

```
CONCAT("Дата рождения ", #2019-01-23#) = "Дата рождения 2019-01-23"
```

```
CONCAT(2019, 01, 23) = "20190123"
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`
