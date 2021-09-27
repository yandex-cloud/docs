---
editable: false
---

# AT_DATE



#### Синтаксис {#syntax}


```
AT_DATE( measure, date_dimension, date_expr [ BEFORE FILTER BY ... ] [ IGNORE DIMENSIONS ... ] )
```

#### Описание {#description}
Вычисляет `measure` для даты/времени, заданных выражением `date_expr`.
Аргумент `date_dimension` задает измерение, вдоль которого делается смещение.

См. также [AGO](AGO.md), [LAG](LAG.md).

**Типы аргументов:**
- `measure` — `Любой`
- `date_dimension` — `Дата | Дата и время`
- `date_expr` — `Дата | Дата и время`


**Возвращаемый тип**: Совпадает с типом аргументов (`measure`)

{% note info %}

Первый аргумент функции должен быть показателем (агрегированным выражением). Отсутствие показателя приведет к ошибке.

{% endnote %}


#### Примеры {#examples}

```
AT_DATE(SUM([Sales]), [Order Date], #2019-01-01#)
```

```
AT_DATE(SUM([Sales]), [Order Date], DATETRUNC([Order Date], "month"))
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
