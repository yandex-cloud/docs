---
editable: false
---

# IN



#### Syntax {#syntax}


```
item [ NOT ] IN (<list>)
```

#### Description {#description}
Checks whether the value matches at least one of the values listed in `IN(...)`.

The option `item NOT IN (<`list`>)` returns the opposite value.

**Argument types:**
- `item` — `Any`
- `list` — `Any`


**Return type**: `Boolean`

#### Examples {#examples}

```
3 IN (23, 5, 3, 67) = TRUE
```

```
3 NOT IN (23, 5, 3, 67) = FALSE
```


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Yandex.Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
