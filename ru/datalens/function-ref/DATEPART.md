---
editable: false
---

# DATEPART



#### Синтаксис {#syntax}


```
DATEPART( datetime, unit [ , firstday ] )
```

#### Описание {#description}
Возвращает часть даты в виде целого числа.

В зависимости от аргумента `unit` возвращает следующие значения:
- `"year"` — номер года (см. [YEAR](YEAR.md));
- `"month"` — номер месяца в году (см. [MONTH](MONTH.md));
- `"week"` — номер недели в году по [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601) (см. [WEEK](WEEK.md));
- `"dayofweek"`, `"dow"` — номер дня недели (см. [DAYOFWEEK](DAYOFWEEK.md));
- `"day"` — номер дня в месяце (см. [DAY](DAY.md));
- `"hour"` — номер часа в дне (см. [HOUR](HOUR.md));
- `"minute"` — номер минуты в часе (см. [MINUTE](MINUTE.md));
- `"second"` — номер секунды в минуте (см. [SECOND](SECOND.md)).

Если выбран "`dayofweek`", то дополнительным параметром `firstday` можно задать, какой день недели считать первым — по умолчанию это понедельник. Более подробно об этом параметре смотрите в описании функции [DAYOFWEEK](DAYOFWEEK.md).


**Типы аргументов:**
- `datetime` — `Дата | Дата и время`
- `unit` — `Строка`
- `firstday` — `Строка`


**Возвращаемый тип**: `Целое число`

{% note info %}

Значения аргументов (`firstday`) должны быть константами.

{% endnote %}


#### Примеры {#examples}

```
DATEPART(#2019-01-23#, "year") = 2019
```

```
DATEPART(#2019-01-23#, "month") = 1
```

```
DATEPART(#2019-01-23#, "day") = 23
```

```
DATEPART(#2019-01-23 11:47:07#, "hour") = 11
```

```
DATEPART(#2019-01-23 11:47:07#, "minute") = 47
```

```
DATEPART(#2019-01-23 11:47:07#, "second") = 7
```

```
DATEPART(#1971-01-14 01:02:03#, "dayofweek") = 4
```

```
DATEPART(#1971-01-14 01:02:03#, "dayofweek", "wed") = 2
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
