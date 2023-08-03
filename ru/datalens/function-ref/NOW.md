---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/NOW.md
---

# NOW



#### Синтаксис {#syntax}


```
NOW()
```

#### Описание {#description}
Возвращает текущую дату и время в зависимости от источника данных и типа соединения.

**Возвращаемый тип**: `Дата и время`

{% note info %}

В `YQL` функция всегда возвращает дату и время в зоне UTC.

{% endnote %}


#### Пример {#examples}

```
NOW() = #2019-01-23 12:53:07#
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
