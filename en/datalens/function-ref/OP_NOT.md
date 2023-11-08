---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/OP_NOT.md
---

# NOT



#### Syntax {#syntax}


```
NOT value
```

#### Description {#description}
Inverts a Boolean value.

**Argument types:**
- `value` — `Boolean | Date | Datetime | Fractional number | Geopoint | Geopolygon | Integer | String`


**Return type**: `Boolean`

#### Examples {#examples}

```
NOT FALSE = TRUE
```

```
NOT TRUE = FALSE
```

```
NOT "" = TRUE
```

```
NOT "text" = FALSE
```

```
NOT 0 = TRUE
```

```
NOT 1 = FALSE
```

```
NOT #2019-01-01# = FALSE
```

```
NOT #2019-01-01 03:00:00# = FALSE
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Yandex Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
