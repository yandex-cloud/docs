---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---


# AGO



#### Синтаксис {#syntax}


```
AGO( measure, date_dimension [ , unit [ , number ] ] [ BEFORE FILTER BY ... ] [ IGNORE DIMENSIONS ... ] )
```

#### Описание {#description}
Вычисляет `measure` для даты/времени с указанным смещением.
Аргумент `date_dimension` задает измерение, вдоль которого делается смещение.
Аргумент `number` задается целым числом. Может принимать отрицательные значения.
Аргумент `unit` принимает следующие значения:
- `"year"` — год;
- `"month"` — месяц;
- `"day"` — день;
- `"hour"` — час;
- `"minute"` — минута;
- `"second"` — секунда.

Возможен вариант использования `AGO( measure, date_dimension, number )`. В этом случае аргумент `unit` — количество дней.

См. также [AT_DATE](AT_DATE.md), [LAG](LAG.md).

**Типы аргументов:**
- `measure` — `Любой`
- `date_dimension` — `Дата | Дата и время`
- `unit` — `Целое число | Строка`
- `number` — `Целое число`


**Возвращаемый тип**: Совпадает с типом аргументов (`measure`)

{% note info %}

Значения аргументов (`unit`, `number`) должны быть константами.

{% endnote %}

{% note info %}

Первый аргумент функции должен быть показателем (агрегированным выражением). Отсутствие показателя приведет к ошибке.

{% endnote %}


#### Примеры {#examples}

```
AGO(SUM([Sales]), [Order Date], "month", 3)
```

```
AGO(SUM([Sales]), [Order Date], "year")
```

```
AGO(SUM([Sales]), [Order Date], 1)
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
