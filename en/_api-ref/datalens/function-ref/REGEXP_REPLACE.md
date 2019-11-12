---
editable: false
---

# REGEXP_REPLACE

_String functions_

#### Syntax


```
REGEXP_REPLACE( string, pattern, replace_with )
```

#### Description
Searches for a substring in the string `string` using the regular expression pattern `pattern` and replaces it with the string `replace_with`.

If the substring is not found, the string is not changed.

**Argument types:**
- `string` — `String`
- `pattern` — `String`
- `replace_with` — `String`


**Return type**: `String`

{% note info %}

Информацию о синтаксисе регулярных выражений уточняйте в документации к источникам данных.

{% endnote %}

Для материализованных датасетов шаблоны описываются в синтаксисе [ClickHouse](https://github.com/google/re2/wiki/Syntax).



#### Examples

```
REGEXP_REPLACE("RU 912873", "\s", "-") = "RU-912873"
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `MySQL 8.0.12`, `PostgreSQL 9.3`
