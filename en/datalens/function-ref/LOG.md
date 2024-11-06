---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/LOG.md
---

# LOG



#### Syntax {#syntax}


```
LOG( value, base )
```

#### Description {#description}
Returns the logarithm of `value` to base `base`. Returns `NULL` if the number `value` is less than or equal to 0.

**Argument types:**
- `value` — `Fractional number | Integer`
- `base` — `Fractional number | Integer`


**Return type**: `Fractional number`

#### Examples {#examples}

```
LOG(1, 2.6) = 0.0
```

```
LOG(1024, 2) = 10.0
```

```
LOG(100, 10) = 2.0
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Yandex Documents`, `YDB`.
