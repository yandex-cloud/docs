---
editable: false
---

# Comparison



#### Syntax {#syntax}

Equality
```
value_1 = value_2
```
Inequality
```
value_1 != value_2
```
Less than
```
value_1 < value_2
```
Less than or equal
```
value_1 <= value_2
```
Greater than
```
value_1 > value_2
```
Greater than or equal
```
value_1 >= value_2
```

#### Description {#description}
Compares the value `value_1` with the value `value_2`.

**Argument types:**
- `value_1` — `Array of fractional numbers | Array of integers | Array of strings | Boolean | Date | Datetime | Fractional number | Geopoint | Geopolygon | Integer | String | UUID`
- `value_2` — `Array of fractional numbers | Array of integers | Array of strings | Boolean | Date | Datetime | Fractional number | Geopoint | Geopolygon | Integer | String | UUID`


**Return type**: `Boolean`

{% note info %}

Due to implementation details of the `Fractional number` type in `ClickHouse` sources it is recommended to use the [COMPARE](COMPARE.md) function instead of comparison operators for this type.

{% endnote %}


#### Examples {#examples}

```
1 = 1 = TRUE
```

```
7 > 2 > 1 = TRUE
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Yandex.Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
