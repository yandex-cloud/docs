---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/OP_POWER.md
---

# Power (^)



#### Syntax {#syntax}


```
base ^ power
```

#### Description {#description}
Raises `base` to the power of `power`.

**Argument types:**
- `base` — `Fractional number | Integer`
- `power` — `Fractional number | Integer`


**Return type**: `Fractional number`

#### Examples {#examples}

```
2 ^ 3 = 8.0
```

```
2.1 ^ -0.3 = 0.80045
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
