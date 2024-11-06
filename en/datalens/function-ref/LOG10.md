---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/LOG10.md
---

# LOG10



#### Syntax {#syntax}


```
LOG10( number )
```

#### Description {#description}
Returns the logarithm of the number `number` to base 10. Returns `NULL` if the number is less than or equal to 0.

**Argument types:**
- `number` — `Fractional number | Integer`


**Return type**: `Fractional number`

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

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Yandex Documents`, `YDB`.
