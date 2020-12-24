---
editable: false
---

# REGEXP_REPLACE



#### Синтаксис {#syntax}


```
REGEXP_REPLACE( string, pattern, replace_with )
```

#### Описание {#description}
Ищет подстроку в строке `string` по шаблону регулярного выражения `pattern` и заменяет ее строкой `replace_with`.

Если подстрока не найдена, то строка не будет изменена.

**Типы аргументов:**
- `string` — `Строка`
- `pattern` — `Строка`
- `replace_with` — `Строка`


**Возвращаемый тип**: `Строка`

{% note info %}

Информацию о синтаксисе регулярных выражений уточняйте в документации к источникам данных.

{% endnote %}

Для материализованных датасетов шаблоны описываются в синтаксисе [ClickHouse](https://github.com/google/re2/wiki/Syntax).



#### Примеры {#examples}

```
REGEXP_REPLACE("RU 912873", "\s", "-") = "RU-912873"
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `MySQL 8.0.12`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
