---
editable: false
---

# Multiplication (*)

_Operators_

#### Syntax


```
value_1 * value_2
```

#### Description
If both arguments are numbers, it returns the result by multiplying `value_1` by `value_2`.

If one of the arguments is `String` and the other is `Number (whole)`, it returns the string repeated the specified number of times.

**Argument types:**
- `value_1` — `Number | String`
- `value_2` — `Number | String`


**Return type**: Depends on argument types

#### Examples

```
2 * 3 = 6
```

```
2.1 * 3 = 6.3
```

```
"Lorem" * 3 = 'LoremLoremLorem'
```

```
3 * "Lorem" = 'LoremLoremLorem'
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`
