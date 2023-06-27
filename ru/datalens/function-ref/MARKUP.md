---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/MARKUP.md
---

# MARKUP



#### Синтаксис {#syntax}


```
MARKUP( arg_1, arg_2, arg_3 [ , ... ] )
```

#### Описание {#description}
Объединяет размеченный текст. Также может быть использован для конвертации обычных строк в размеченный текст.

**Типы аргументов:**
- `arg_1` — `Разметка | Строка`
- `arg_2` — `Разметка | Строка`
- `arg_3` — `Разметка | Строка`


**Возвращаемый тип**: `Разметка`

#### Пример {#examples}

```
MARKUP(BOLD([a]), ': ', [b])
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
