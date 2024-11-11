---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/OP_MULT.md
---

# Multiplication (*)



#### Syntax {#syntax}


```
value_1 * value_2
```

#### Description {#description}
If both arguments are numbers, it returns the result by multiplying `value_1` by `value_2`.

If one of the arguments is `String` and the other is `Integer`, it returns the string repeated the specified number of times.

**Argument types:**
- `value_1` — `Fractional number | Integer | String`
- `value_2` — `Fractional number | Integer | String`


**Return type**: Depends on argument types

#### Examples {#examples}

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


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Yandex Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Yandex Documents`, `YDB`.
