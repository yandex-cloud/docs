---
editable: false
---

# REGEXP_MATCH

_String functions_

#### Syntax


```
REGEXP_MATCH( string, pattern )
```

#### Description
Returns 'TRUE' if the string `string` has a substring that matches the regular expression pattern `pattern`.


**Argument types:**
- `string` — `String`
- `pattern` — `String`


**Return type**: `Boolean`

{% note info %}

Информацию о синтаксисе регулярных выражений уточняйте в документации к источникам данных.

{% endnote %}

Для материализованных датасетов шаблоны описываются в синтаксисе [ClickHouse](https://github.com/google/re2/wiki/Syntax).



#### Examples

```
REGEXP_MATCH("RU 912873","\w\s\d") = TRUE
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `MySQL 5.6`, `PostgreSQL 9.3`
