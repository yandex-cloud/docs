---
editable: false

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# Comparison



#### Syntax {#syntax}

Version 1:
```
value_1 = value_2
```
Version 2:
```
value_1 != value_2
```
Version 3:
```
value_1 < value_2
```
Version 4:
```
value_1 <= value_2
```
Version 5:
```
value_1 > value_2
```
Version 6:
```
value_1 => value_2
```

#### Description {#description}
Compares the value `value_1` with the value `value_2`.

**Argument types:**
- `value_1` — `Boolean | Date | Datetime | Fractional number | Geopoint | Geopolygon | Integer | String | UUID`
- `value_2` — `Boolean | Date | Datetime | Fractional number | Geopoint | Geopolygon | Integer | String | UUID`


**Return type**: `Boolean`

#### Examples {#examples}

```
1 = 1 = TRUE
```

```
7 > 2 > 1 = TRUE
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Yandex.Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
