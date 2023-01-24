---
editable: false
---

# CONCAT



#### Syntax {#syntax}


```
CONCAT( arg_1, arg_2, arg_3 [ , ... ] )
```

#### Description {#description}
Merges any number of strings. When non-string types are used, they're converted to strings and then merged.

**Argument types:**
- `arg_1` — `Boolean | Date | Datetime | Fractional number | Geopoint | Geopolygon | Integer | String | UUID`
- `arg_2` — `Boolean | Date | Datetime | Fractional number | Geopoint | Geopolygon | Integer | String | UUID`
- `arg_3` — `Boolean | Date | Datetime | Fractional number | Geopoint | Geopolygon | Integer | String | UUID`


**Return type**: `String`

#### Examples {#examples}

```
CONCAT("Дата рождения ", #2019-01-23#) = "Дата рождения 2019-01-23"
```

```
CONCAT(2019, 01, 23) = "20190123"
```


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Yandex Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
