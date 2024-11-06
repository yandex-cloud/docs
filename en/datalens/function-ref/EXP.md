---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/EXP.md
---

# EXP



#### Syntax {#syntax}


```
EXP( number )
```

#### Description {#description}
Returns the result of raising the number 'e' to the power of `number`.

**Argument types:**
- `number` — `Fractional number | Integer`


**Return type**: `Fractional number`

#### Examples {#examples}

```
EXP(0) = 1.0
```

```
EXP(1) = 2.718282
```

```
EXP(3) = 20.08553
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Yandex Documents`, `YDB`.
