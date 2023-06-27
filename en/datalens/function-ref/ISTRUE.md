---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/ISTRUE.md
---

# IS TRUE



#### Syntax {#syntax}


```
value IS [ NOT ] TRUE
```

#### Description {#description}
Checks whether the value of `value` is true (`TRUE`).

The `value IS NOT TRUE` option returns the opposite value.

**Argument types:**
- `value` — `Boolean | Date | Datetime | Fractional number | Geopoint | Geopolygon | Integer | String`


**Return type**: `Boolean`

#### Examples {#examples}

```
"qwerty" IS TRUE = TRUE
```

```
123 IS TRUE = TRUE
```

```
TRUE IS TRUE = TRUE
```

```
FALSE IS TRUE = FALSE
```

```
FALSE IS NOT TRUE = TRUE
```

```
#2019-03-05# IS TRUE = TRUE
```

```
#2019-03-05 01:02:03# IS TRUE = TRUE
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
