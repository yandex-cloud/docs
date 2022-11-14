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
- `"quarter"` — номер квартала года (от `1` до `4`) (см. [QUARTER](QUARTER.md));
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

{% cut "Пример с датой" %}


Формулы:

- **Date**: `[Date]` ;
- **Year**: `DATEPART([Date], "year")` ;
- **Month**: `DATEPART([Date], "month")` ;
- **Day**: `DATEPART([Date], "day")` ;
- **DayOfWeek**: `DATEPART([Date], "dayofweek")` ;
- **DOW**: `DATEPART([Date], "dow")` .

| **Date**     | **Year**   | **Month**   | **Day**   | **DayOfWeek**   | **DOW**   |
|:-------------|:-----------|:------------|:----------|:----------------|:----------|
| `2014-10-06` | `2014`     | `10`        | `6`       | `1`             | `1`       |
| `2014-10-07` | `2014`     | `10`        | `7`       | `2`             | `2`       |
| `2017-03-08` | `2017`     | `3`         | `8`       | `3`             | `3`       |
| `2024-02-12` | `2024`     | `2`         | `12`      | `1`             | `1`       |

{% endcut %}

{% cut "Пример с заданным первым днем недели" %}


Формулы:

- **Date**: `[Date]` ;
- **DOW**: `DATEPART([Date], "dow")` ;
- **DOW sun**: `DATEPART([Date], "dow", "sun")` ;
- **DOW Monday**: `DATEPART([Date], "dow", "Monday")` ;
- **DOW wed**: `DATEPART([Date], "dow", "wed")` .

| **Date**     | **DOW**   | **DOW sun**   | **DOW Monday**   | **DOW wed**   |
|:-------------|:----------|:--------------|:-----------------|:--------------|
| `2014-10-06` | `1`       | `2`           | `1`              | `6`           |
| `2014-10-07` | `2`       | `3`           | `2`              | `7`           |
| `2017-03-08` | `3`       | `4`           | `3`              | `1`           |
| `2024-02-12` | `1`       | `2`           | `1`              | `6`           |

{% endcut %}

{% cut "Пример с датой и временем" %}


Формулы:

- **DateTime**: `[DateTime]` ;
- **Year**: `DATEPART([DateTime], "year")` ;
- **Month**: `DATEPART([DateTime], "month")` ;
- **Day**: `DATEPART([DateTime], "day")` ;
- **Hour**: `DATEPART([DateTime], "hour")` ;
- **Minute**: `DATEPART([DateTime], "minute")` ;
- **Second**: `DATEPART([DateTime], "second")` .

| **DateTime**          | **Year**   | **Month**   | **Day**   | **Hour**   | **Minute**   | **Second**   |
|:----------------------|:-----------|:------------|:----------|:-----------|:-------------|:-------------|
| `2014-10-06T07:45:12` | `2014`     | `10`        | `6`       | `7`        | `45`         | `12`         |
| `2014-10-07T11:10:15` | `2014`     | `10`        | `7`       | `11`       | `10`         | `15`         |
| `2017-03-08T23:59:59` | `2017`     | `3`         | `8`       | `23`       | `59`         | `59`         |
| `2024-02-12T07:40:33` | `2024`     | `2`         | `12`      | `7`        | `40`         | `33`         |

{% endcut %}


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
