---
editable: false
---

# ZN

_Logical functions_

#### Syntax {#syntax}


```
ZN( expression )
```

#### Description {#description}
Returns `expression` if it's not `NULL`. Otherwise returns 0.

**Argument types:**
- `expression` — `Number`


**Return type**: Same type as (`expression`)

#### Examples {#examples}

```
ZN(1) = 1
```

```
ZN(NULL) = 0
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
