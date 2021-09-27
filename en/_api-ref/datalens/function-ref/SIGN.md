---
editable: false
---

# SIGN



#### Syntax {#syntax}


```
SIGN( number )
```

#### Description {#description}
Returns the sign of the number `number`:
- `-1` if the number is negative.
`0` if the number is zero.
- `1` if the number is positive.

**Argument types:**
- `number` — `Fractional number | Integer`


**Return type**: `Integer`

#### Examples {#examples}

```
SIGN(-115) = -1
```

```
SIGN(0) = 0
```

```
SIGN(78) = 1
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
