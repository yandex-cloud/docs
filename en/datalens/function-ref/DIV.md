---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/DIV.md
---

# DIV



#### Syntax {#syntax}


```
DIV( number_1, number_2 )
```

#### Description {#description}
Divides `number_1` by `number_2`. The result is rounded down to the nearest integer.

**Argument types:**
- `number_1` — `Fractional number | Integer`
- `number_2` — `Fractional number | Integer`


**Return type**: `Integer`

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

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
