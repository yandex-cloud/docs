---
editable: false
---

# NOT



#### Syntax {#syntax}


```
NOT value
```

#### Description {#description}
Inverts a Boolean value.

**Argument types:**
- `value` — `Boolean | Date | Datetime | Geopoint | Geopolygon | Number | String`


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

`Materialized Dataset`, `ClickHouse 1.1`, `Yandex.Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
