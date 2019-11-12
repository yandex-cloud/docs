---
editable: false
---

# IS FALSE

_Operators_

#### Syntax


```
value IS [ NOT ] FALSE
```

#### Description
Checks whether the `value` value is false (`FALSE`).

The `value IS NOT FALSE` option returns the opposite value.

**Argument types:**
- `value` — `Any`


**Return type**: `Boolean`

#### Examples

```
"" IS FALSE = TRUE
```

```
0 IS FALSE = TRUE
```

```
FALSE IS FALSE = TRUE
```

```
TRUE IS FALSE = FALSE
```

```
TRUE IS NOT FALSE = TRUE
```

```
#2019-03-05# IS FALSE = FALSE
```

```
#2019-03-05 01:02:03# IS FALSE = FALSE
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`
