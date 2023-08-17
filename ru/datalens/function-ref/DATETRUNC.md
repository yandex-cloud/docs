---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/DATETRUNC.md
---

# DATETRUNC



#### Синтаксис {#syntax}


```
DATETRUNC( datetime, unit [ , number ] )
```

#### Описание {#description}
Возвращает дату, округленную по аргументу `unit`.

Если задан аргумент `number`, то происходит округление до этого количества временных единиц. Отсутствие аргумента эквивалентно значению `1`.

Поддерживаемые значения `unit`:
- `"second"`;
- `"minute"`;
- `"hour"`;
- `"day"` (при заданном `number` используется номер дня в году);
- `"week"`;
- `"month"`;
- `"quarter"`;
- `"year"`.

**Типы аргументов:**
- `datetime` — `Дата | Дата и время`
- `unit` — `Строка`
- `number` — `Целое число`


**Возвращаемый тип**: Совпадает с типом аргументов (`datetime`)

{% note info %}

Значения аргументов (`unit`, `number`) должны быть константами.

{% endnote %}

{% note info %}

Функция с тремя аргументами доступна только для источников `ClickHouse` версии `21.8` и выше.

{% endnote %}


#### Примеры {#examples}

```
DATETRUNC(#2018-07-12 11:07:13#, "minute") = #2018-07-12 11:07:00#
```

```
DATETRUNC(#2018-07-12#, "year", 5) = #2015-01-01#
```

```
DATETRUNC(#2018-07-12 11:07:13#, "second", 5) = #2018-07-12 11:07:10#
```

```
DATETRUNC(#2018-07-12 11:07:13#, "month", 4) = #2018-05-01 00:00:00#
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
