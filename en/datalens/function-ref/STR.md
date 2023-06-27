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

{% note info %}

If an array is passed (only for `ClickHouse`, `PostgreSQL` sources), the conversion is performed by a function in the source database and results may vary for different data sources. For consistent results use [ARR_STR](ARR_STR.md).

{% endnote %}


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

```
STR(ARRAY(1, 2, 3, NULL)) = {1,2,3,NULL}  PostgreSQL
```

```
STR(ARRAY(1, 2, 3, NULL)) = [1,2,3,NULL]  ClickHouse
```

```
STR(ARRAY('a', 'b', '', NULL)) = {a,b,,NULL}  PostgreSQL
```

```
STR(ARRAY('a', 'b', '', NULL)) = ['a','b','',NULL]  ClickHouse
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
