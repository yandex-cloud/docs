---
editable: false
---

# LN

_Mathematical functions_

#### Syntax {#syntax}


```
LN( number )
```

#### Description {#description}
Returns the natural logarithm of the number `number`. Returns 'NULL' if the number is less than or equal to 0.

**Argument types:**
- `number` — `Number`


**Return type**: `Number (decimal)`

#### Examples {#examples}

```
LN(1) = 0.0
```

```
LN(EXP(2)) = 2.0
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
