---
editable: false
---

# LOG10



#### Syntax {#syntax}


```
LOG10( number )
```

#### Description {#description}
Returns the logarithm of the number `number` to base 10. Returns 'NULL' if the number is less than or equal to 0.

**Argument types:**
- `number` — `Number`


**Return type**: `Number (decimal)`

#### Examples {#examples}

```
LOG10(1) = 0.0
```

```
LOG10(1000) = 3.0
```

```
LOG10(100) = 2.0
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
