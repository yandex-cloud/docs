## DATEPART

_Функции даты и времени_

#### Синтаксис


```
DATEPART( datetime, unit [ , firstday ] )
```

#### Описание
Возвращает часть даты в виде целого числа.

В зависимости от аргумента `datetime` возвращает следующие значения:
- `"year"` — номер года (см. [YEAR](../../date/YEAR/overview.md)),
- `"month"` — номер месяца в году (см. [MONTH](../../date/MONTH/overview.md)),
- `"week"` — номер недели в году по [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601) (см. [WEEK](../../date/WEEK/overview.md)),
- `"dayofweek"`, `"dow"` — номер дня недели (см. [DAYOFWEEK](../../date/DAYOFWEEK/overview.md)),
- `"day"` — номер дня в месяце (см. [DAY](../../date/DAY/overview.md)),
- `"hour"` — номер часа в дне (см. [HOUR](../../date/HOUR/overview.md)),
- `"minute"` — номер минуты в часе (см. [MINUTE](../../date/MINUTE/overview.md)),
- `"second"` — номер секунды в минуте (см. [SECOND](../../date/SECOND/overview.md)).

Если выбран "`dayofweek`", то дополнительным параметром `firstday` можно задать, какой день недели считать первым - по умолчанию это понедельник.  
Более подробно об этом параметре смотрите в описании функции [DAYOFWEEK](../../date/DAYOFWEEK/overview.md)


**Типы аргументов:**
- `datetime` - `Дата | Дата со временем`
- `unit` - `Строка`
- `firstday` - `Строка`


**Возвращаемый тип**: `Целое число`

> [!NOTE]
>
> Значения аргументов (firstday) должны быть константами.



#### Примеры

```
DATEPART("year", #2019-01-23#) = 2019
```

```
DATEPART("month", #2019-01-23#) = 1
```

```
DATEPART("day", #2019-01-23#) = 23
```

```
DATEPART("hour", #2019-01-23 11:47:07#) = 11
```

```
DATEPART("minute", #2019-01-23 11:47:07#) = 47
```

```
DATEPART("second", #2019-01-23 11:47:07#) = 7
```

```
DATEPART(#1971-01-14 01:02:03#, "dayofweek") = 4
```

```
DATEPART(#1971-01-14 01:02:03#, "dayofweek", "wed") = 2
```


#### Поддержка источников данных

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`
