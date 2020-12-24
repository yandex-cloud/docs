---
editable: false
---

# DATETIME



#### Синтаксис {#syntax}


```
DATETIME( expression [ , timezone ] )
```

#### Описание {#description}
Переводит выражение `expression` в формат даты и времени. При переводе `Date` в `DateTime` время определяется, как `00:00:00`.
Дата должна быть определена в формате `YYYY-MM-DDThh:mm:ss` или `YYYY-MM-DD hh:mm:ss`.

Если `expression` является числом, то при наличии дополнительного параметра `timezone` дата и время расчитываются для указанной временной зоны.

**Типы аргументов:**
- `expression` — `Дата | Дата и время | Число | Строка`
- `timezone` — `Строка`


**Возвращаемый тип**: `Дата и время`

{% note info %}

Значения аргументов (`timezone`) должны быть константами.

{% endnote %}

{% note info %}

Параметр `timezone` доступен только для источников `Материализованный датасет`, `ClickHouse`.

{% endnote %}


#### Примеры {#examples}

```
DATETIME("2019-01-23 15:07:47") = #2019-01-23 15:07:47#
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
