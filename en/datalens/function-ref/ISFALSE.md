---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/ISFALSE.md
---

# IS FALSE



#### Syntax {#syntax}


```
value IS [ NOT ] FALSE
```

#### Description {#description}
Checks whether the `value` value is false (`FALSE`).

The `value IS NOT FALSE` option returns the opposite value.

**Argument types:**
- `value` — `Boolean | Date | Datetime | Fractional number | Geopoint | Geopolygon | Integer | String`


**Return type**: `Boolean`

#### Examples {#examples}

```
"" IS FALSE = TRUE
```

```
0 IS FALSE = TRUE
```

```
FALSE IS FALSE = TRUE
```

```
TRUE IS FALSE = FALSE
```

```
TRUE IS NOT FALSE = TRUE
```

```
#2019-03-05# IS FALSE = FALSE
```

```
#2019-03-05 01:02:03# IS FALSE = FALSE
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
