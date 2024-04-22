---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/REGEXP_REPLACE.md
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

Информацию о синтаксисе регулярных выражений уточняйте в документации к источникам данных. Например, в `ClickHouse` для составления регулярных выражений используется [синтаксис RE2](https://github.com/google/re2/wiki/Syntax).

{% endnote %}


#### Пример {#examples}

```
REGEXP_REPLACE("123 456", "\s", "-") = "123-456"
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `MySQL 8.0.12`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
