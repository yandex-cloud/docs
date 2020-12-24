---
editable: false
---

# DATE



#### Синтаксис {#syntax}


```
DATE( expression [ , timezone ] )
```

#### Описание {#description}
Переводит выражение `expression` в формат даты.

Дата должна быть определена в формате `YYYY-MM-DD`.

Если `expression` является числом, то при наличии дополнительного параметра `timezone` дата расчитывается для указанной временной зоны.

**Типы аргументов:**
- `expression` — `Дата | Дата и время | Число | Строка`
- `timezone` — `Строка`


**Возвращаемый тип**: `Дата`

{% note info %}

Значения аргументов (`timezone`) должны быть константами.

{% endnote %}

{% note info %}

Параметр `timezone` доступен только для источников `Материализованный датасет`, `ClickHouse`.

{% endnote %}


#### Примеры {#examples}

```
DATE("2019-01-23") = #2019-01-23#
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
