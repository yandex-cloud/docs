---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/STR.md
---


# STR



#### Syntax {#syntax}


```
STR( expression )
```

#### Description {#description}
Converts the `expression` expression to string type.

**Argument types:**
- `expression` — `Array of fractional numbers | Array of integers | Array of strings | Boolean | Date | Datetime | Fractional number | Geopoint | Geopolygon | Integer | String | UUID`


**Return type**: `String`

#### Examples {#examples}

```
STR(77) = "77"
```

```
STR(1 != 1) = "False"
```

```
STR(#2019-01-01#) = "2019-01-01"
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
