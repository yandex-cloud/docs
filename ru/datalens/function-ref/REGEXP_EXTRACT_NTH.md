---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/REGEXP_EXTRACT_NTH.md
---

# REGEXP_EXTRACT_NTH



#### Синтаксис {#syntax}


```
REGEXP_EXTRACT_NTH( string, pattern, match_index )
```

#### Описание {#description}
Возвращает подстроку `string`, которая соответствует шаблону регулярного выражения `pattern`, начиная с указанного индекса.

**Типы аргументов:**
- `string` — `Строка`
- `pattern` — `Строка`
- `match_index` — `Целое число`


**Возвращаемый тип**: `Строка`

{% note info %}

Значения аргументов (`pattern`) должны быть константами.

{% endnote %}

{% note info %}

Информацию о синтаксисе регулярных выражений уточняйте в документации к источникам данных.

{% endnote %}


#### Пример {#examples}

```
REGEXP_EXTRACT_NTH("RU 912 EN 873", "[A-Z]+\s+(\d+)", 2) = "873"
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `MySQL 8.0.12`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
