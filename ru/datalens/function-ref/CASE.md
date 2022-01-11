---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/CASE.md
---


# CASE



#### Синтаксис {#syntax}

Вариант 1:
```
CASE expression
    WHEN value_1 THEN result_1
    [ WHEN value_2 THEN result_2
      ... ]
    ELSE default_result
END
```
Вариант 2:
```
CASE(
    expression,
    value_1, result_1,
  [ value_2, result_2,
    ... ]
    default_result
)
```

#### Описание {#description}
Сравнивает выражение `expression` с последовательностью значений `value_1`, `value_2`, ... и возвращает результат для первого совпадения.
Если совпадений не найдено, то возвращает `default_result`.

**Типы аргументов:**
- `expression` — `Любой`
- `value_1` — `Любой`
- `result_1` — `Любой`
- `value_2` — `Любой`
- `result_2` — `Любой`
- `default_result` — `Любой`


**Возвращаемый тип**: Совпадает с типом аргументов (`result_1`, `result_2`, `default_result`)

{% note info %}

Тип аргументов (`result_1`, `result_2`, `default_result`) должен совпадать.

{% endnote %}


#### Примеры {#examples}

```
CASE (
    [country],
    "BY", "Белоруссия",
    "KZ", "Казахстан",
    "RU", "Россия",
    "TR", "Турция",
    "UZ", "Узбекистан",
    "Другая страна"
)
```

```
CASE [country]
    WHEN "BY" THEN "Белоруссия"
    WHEN "KZ" THEN "Казахстан"
    WHEN "RU" THEN "Россия"
    WHEN "TR" THEN "Турция"
    WHEN "UZ" THEN "Узбекистан"
    ELSE "Другая страна"
END
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
