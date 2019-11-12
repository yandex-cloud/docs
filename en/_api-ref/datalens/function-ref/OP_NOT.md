---
editable: false
---

# NOT

_Operators_

#### Syntax


```
NOT value
```

#### Description
Inverts a Boolean value.

**Argument types:**
- `value` — `Any`


**Return type**: `Boolean`

#### Examples

```
NOT FALSE = TRUE
```

```
NOT TRUE = FALSE
```

```
NOT "" = TRUE
```

```
NOT "text" = FALSE
```

```
NOT 0 = TRUE
```

```
NOT 1 = FALSE
```

```
NOT #2019-01-01# = FALSE
```

```
NOT #2019-01-01 03:00:00# = FALSE
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`
