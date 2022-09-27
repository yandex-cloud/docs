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

**Возвращаемый тип**: `Дата и время (устаревший)`

{% note info %}

При материализации функция возвращает дату и время по Московскому времени.

{% endnote %}


#### Пример {#examples}

```
NOW() = #2019-01-23 12:53:07#
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
