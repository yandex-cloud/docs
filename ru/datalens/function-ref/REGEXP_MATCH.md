---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/REGEXP_MATCH.md
---

# REGEXP_MATCH



#### Синтаксис {#syntax}


```
REGEXP_MATCH( string, pattern )
```

#### Описание {#description}
Возвращает `TRUE`, если в строке `string` есть подстрока, которая соответствует шаблону регулярного выражения `pattern`.

**Типы аргументов:**
- `string` — `Строка`
- `pattern` — `Строка`


**Возвращаемый тип**: `Логический`

{% note info %}

Информацию о синтаксисе регулярных выражений уточняйте в документации к источникам данных. Например, в `ClickHouse` для составления регулярных выражений используется [синтаксис RE2](https://github.com/google/re2/wiki/Syntax).

{% endnote %}


#### Пример {#examples}

```
REGEXP_MATCH("RU 912873","\w\s\d") = TRUE
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Файлы`, `Google Sheets`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Яндекс Документы`.
