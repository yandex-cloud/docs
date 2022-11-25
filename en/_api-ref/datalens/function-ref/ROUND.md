---
editable: false
---

# ROUND



#### Syntax {#syntax}


```
ROUND( number [ , precision ] )
```

#### Description {#description}
Rounds the number `number` to the number of decimal digits specified in `precision`.
If the number `precision` is omitted, `number` is rounded to the nearest integer.

**Argument types:**
- `number` — `Fractional number | Integer`
- `precision` — `Integer`


**Return type**: Depends on argument types

#### Examples {#examples}

```
ROUND(3.14159) = 3
```

```
ROUND(3.14159, 3) = 3.142
```


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
