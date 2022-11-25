---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/OP_MOD.md
---

# Modulo (%)



#### Syntax {#syntax}


```
number_1 % number_2
```

#### Description {#description}
Returns the remainder from dividing the first number `number_1` by the second number `number_2`.

**Argument types:**
- `number_1` — `Fractional number | Integer`
- `number_2` — `Fractional number | Integer`


**Return type**: Depends on argument types

#### Examples {#examples}

```
2 % 3 = 2
```

```
2.1 % 3 = 2.1
```

```
3 % 2.1 = 0.9
```


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
