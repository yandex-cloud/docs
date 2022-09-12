---
editable: false
---

# DATE



#### Синтаксис {#syntax}


```
DATE( expression [ , timezone ] )
```

#### Описание {#description}

{% note warning %}

Источники `ClickHouse` воспринимают числовые значения `expression` меньше или равные `65535` как количество дней (не секунд, как во всех остальных случаях) с 1 января 1970 г. Это следствие поведения доступных в `ClickHouse` функций.

Чтобы обойти это, воспользуйтесь формулой: `DATE(DATETIME([value]))`. Формула имеет более корректное поведение, но может работать значительно медленнее.

{% endnote %}

Переводит выражение `expression` в формат даты.

Дата должна быть определена в формате `YYYY-MM-DD`.

Если `expression` является числом, то при наличии дополнительного параметра `timezone` дата рассчитывается для указанной временной зоны.

**Типы аргументов:**
- `expression` — `Дата | Дата и время | Дата и время (устаревший) | Дробное число | Целое число | Строка`
- `timezone` — `Строка`


**Возвращаемый тип**: `Дата`

{% note info %}

Значения аргументов (`timezone`) должны быть константами.

{% endnote %}

{% note info %}

Параметр `timezone` доступен только для источников `Материализованный датасет`, `ClickHouse`.

{% endnote %}


#### Пример {#examples}

```
DATE("2019-01-23") = #2019-01-23#
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.