---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/REGEXP_EXTRACT_ALL.md
---

# REGEXP_EXTRACT_ALL



#### Синтаксис {#syntax}


```
REGEXP_EXTRACT_ALL( string, pattern )
```

#### Описание {#description}
Возвращает все подстроки `string`, которые соответствуют регулярному выражению `pattern`. Для регулярных выражений с подгруппами работает только для первой подгруппы.

**Типы аргументов:**
- `string` — `Строка`
- `pattern` — `Строка`


**Возвращаемый тип**: `Массив строк`

{% note info %}

Значения аргументов (`pattern`) должны быть константами.

{% endnote %}

{% note info %}

Информацию о синтаксисе регулярных выражений уточняйте в документации к источникам данных. Например, в `ClickHouse` для составления регулярных выражений используется [синтаксис RE2](https://github.com/google/re2/wiki/Syntax).

{% endnote %}


#### Пример {#examples}

```
REGEXP_EXTRACT_ALL("100-200, 300-400", "(\d+)-(\d+)") = ["100","300"]
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `PostgreSQL 9.3`.
