---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/REGEXP_EXTRACT.md
---

# REGEXP_EXTRACT



#### Синтаксис {#syntax}


```
REGEXP_EXTRACT( string, pattern )
```

#### Описание {#description}
Возвращает подстроку `string`, которая соответствует регулярному выражению `pattern`.

**Типы аргументов:**
- `string` — `Строка`
- `pattern` — `Строка`


**Возвращаемый тип**: `Строка`

{% note info %}

Значения аргументов (`pattern`) должны быть константами.

{% endnote %}

{% note info %}

Информацию о синтаксисе регулярных выражений уточняйте в документации к источникам данных. Например, в `ClickHouse` для составления регулярных выражений используется [синтаксис RE2](https://github.com/google/re2/wiki/Syntax).

{% endnote %}


#### Пример {#examples}

```
REGEXP_EXTRACT("RU 912873", "[A-Z]+\s+(\d+)") = "912873"
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `MySQL 8.0.12`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
