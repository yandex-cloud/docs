---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/LIKE.md
---

# LIKE



#### Синтаксис {#syntax}


```
string_1 [ NOT ] LIKE string_2
```

#### Описание {#description}
Сравнивает строку `string_1` со шаблоном `string_2` и в случае совпадения возвращает `TRUE`.
В качестве `string_2` можно задать значение или использовать знак `%`, который соответствует строке любой длины.

Вариант `string_1 NOT LIKE` возвращает противоположное значение.

**Типы аргументов:**
- `string_1` — `Строка`
- `string_2` — `Строка`


**Возвращаемый тип**: `Логический`

#### Примеры {#examples}

```
"raspberry" LIKE "%spb%" = TRUE
```

```
"raspberry" NOT LIKE "%spb%" = FALSE
```

```
IIF([Country] LIKE 'RU', 'Y', 'N')
```

```
IIF([Phone] LIKE '+7%', 'RU', 'notRU')
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
