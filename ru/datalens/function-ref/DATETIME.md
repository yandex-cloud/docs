---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/DATETIME.md
---

# DATETIME



#### Синтаксис {#syntax}


```
DATETIME( expression [ , timezone ] )
```

#### Описание {#description}
Переводит выражение `expression` в формат даты и времени. При переводе `Date` в `DateTime` время определяется, как `00:00:00`.
Дата должна быть определена в формате `YYYY-MM-DDThh:mm:ss` или `YYYY-MM-DD hh:mm:ss`.
Числовые значения воспринимаются как время в формате [Unix time](https://ru.wikipedia.org/wiki/Unix-время) и равны количеству секунд, прошедших с 00:00:00 1 января 1970 года, за вычетом поправок, сделанных из-за високосных секунд.

При наличии дополнительного параметра `timezone` дата и время рассчитываются для указанной [временной зоны](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List). Параметр `timezone` должен быть определен в формате `Region/Data_Zone`.

**Типы аргументов:**
- `expression` — `Дата | Дата и время | Дробное число | Целое число | Строка`
- `timezone` — `Строка`


**Возвращаемый тип**: `Дата и время`

{% note info %}

Значения аргументов (`timezone`) должны быть константами.

{% endnote %}

{% note info %}

Параметр `timezone` доступен только для источников `ClickHouse`.

{% endnote %}


#### Примеры {#examples}

```
DATETIME("2019-01-23 15:07:47") = #2019-01-23 15:07:47#
```

```
DATETIME("2019.01.02 03:04:05") = #2019-01-02 03:04:05#
```

```
DATETIME("2019-01-23") = #2019-01-23 00:00:00#
```

```
DATETIME(1576807650) = #2019-12-20 02:07:30#
```

```
DATETIME(1576807650.793) = #2019-12-20 02:07:30#
```

```
DATETIME(1576807650.793, 'Asia/Hong_Kong') = #2019-12-20 10:07:30#
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Файлы`, `Google Sheets`, `Yandex Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Яндекс Документы`, `YDB`.
