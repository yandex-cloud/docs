---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/DAYOFWEEK.md
---

# DAYOFWEEK



#### Синтаксис {#syntax}


```
DAYOFWEEK( datetime [ , firstday ] )
```

#### Описание {#description}
Возвращает день недели в соответствии с [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601).
- Понедельник — 1;
- Воскресенье — 7.

Если указан дополнительный параметр `firstday`, то этот день считается первым в неделе. Допустимые значения:
- `"Monday"`, `"Mon"` — понедельник;
- `"Tuesday"`, `"Tue"` — вторник;
- `"Wednesday"`, `"Wed"` — среда;
- `"Thursday"`, `"Thu"` — четверг;
- `"Friday"`, `"Fri"` — пятница;
- `"Saturday"`, `"Sat"` — суббота;
- `"Sunday"`, `"Sun"` — воскресенье.


**Типы аргументов:**
- `datetime` — `Дата | Дата и время`
- `firstday` — `Строка`


**Возвращаемый тип**: `Целое число`

{% note info %}

Значения аргументов (`firstday`) должны быть константами.

{% endnote %}


#### Примеры {#examples}

```
DAYOFWEEK(#1971-01-14 01:02:03#) = 4
```

```
DAYOFWEEK(#1971-01-14#, "wed") = 2
```

```
DAYOFWEEK(#1971-01-14#, "wednesday") = 2
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
