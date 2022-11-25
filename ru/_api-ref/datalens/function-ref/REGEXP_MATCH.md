---
editable: false
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

Информацию о синтаксисе регулярных выражений уточняйте в документации к источникам данных.

{% endnote %}

Для материализованных датасетов шаблоны описываются в синтаксисе [ClickHouse](https://github.com/google/re2/wiki/Syntax).



#### Пример {#examples}

```
REGEXP_MATCH("RU 912873","\w\s\d") = TRUE
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
