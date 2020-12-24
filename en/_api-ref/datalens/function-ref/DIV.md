---
editable: false
---

# DIV



#### Syntax {#syntax}


```
DIV( number_1, number_2 )
```

#### Description {#description}
Divides `number_1` by `number_1`. The result is rounded down to the nearest integer.

**Argument types:**
- `number_1` — `Number`
- `number_2` — `Number`


**Return type**: `Number (whole)`

#### Examples {#examples}

```
DIV(4, 2) = 2
```

```
DIV(5, 3) = 1
```

```
DIV(5.0, 2) = 2
```

```
DIV(2.5, 1.2) = 2
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
