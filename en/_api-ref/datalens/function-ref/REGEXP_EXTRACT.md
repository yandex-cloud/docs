---
editable: false
---

# REGEXP_EXTRACT

_String functions_

#### Syntax


```
REGEXP_EXTRACT( string, pattern )
```

#### Description
Returns the substring `string` that matches the regular expression pattern `pattern`.


**Argument types:**
- `string` — `String`
- `pattern` — `String`


**Return type**: `String`

{% note info %}

Only constant values are accepted for arguments (pattern).

{% endnote %}

{% note info %}

Информацию о синтаксисе регулярных выражений уточняйте в документации к источникам данных.

{% endnote %}

Для материализованных датасетов шаблоны описываются в синтаксисе [ClickHouse](https://github.com/google/re2/wiki/Syntax).



#### Examples

```
REGEXP_EXTRACT("RU 912873", "[A-Z]+\s+(\d+)") = "912873"
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `MySQL 8.0.12`, `PostgreSQL 9.3`
