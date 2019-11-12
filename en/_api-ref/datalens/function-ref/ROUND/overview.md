---
editable: false
---

# ROUND

_Mathematical functions_

#### Syntax


```
ROUND( number [ , precision ] )
```

#### Description
Rounds the number `number` to the number of decimal digits specified in `precision`.
If the number `precision` is omitted, `number` is rounded to the nearest integer.

**Argument types:**
- `number` — `Number`
- `precision` — `Number (whole)`


**Return type**: Depends on argument types

#### Examples

```
ROUND(3.14159) = 3
```

```
ROUND(3.14159, 3) = 3.142
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`
