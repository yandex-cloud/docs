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

При наличии дополнительного параметра `timezone` дата и время рассчитываются для указанной временной зоны.

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


#### Пример {#examples}

```
DATETIME("2019-01-23 15:07:47") = #2019-01-23 15:07:47#
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `Yandex Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
