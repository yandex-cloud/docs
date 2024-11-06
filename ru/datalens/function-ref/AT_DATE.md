---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/AT_DATE.md
---

# AT_DATE



#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  AT_DATE( measure, date_dimension, date_expr )
  ```

- Расширенный

  ```
  AT_DATE( measure, date_dimension, date_expr
           [ BEFORE FILTER BY ... ]
           [ IGNORE DIMENSIONS ... ]
         )
  ```

  Подробнее:
  - [BEFORE FILTER BY](time-series-functions.md#syntax-before-filter-by)
  - [IGNORE DIMENSIONS](time-series-functions.md#syntax-ignore-dimensions)

{% endlist %}

#### Описание {#description}
Вычисляет `measure` для даты/времени, заданных выражением `date_expr`. Позволяет получить показатель на начало или конец периода, или на конкретную дату.
Аргумент `date_dimension` задает измерение, вдоль которого делается смещение.

В качестве аргумента `date_expr` можно использовать:

* конкретную дату;
* функцию получения текущей даты [TODAY](TODAY.md);
* функции для вычисления даты и времени.

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
AT_DATE(SUM([Sales]), [Order Date], TODAY())
```

```
AT_DATE(SUM([Sales]), [Order Date], DATETRUNC([Order Date], "month"))
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Файлы`, `Google Sheets`, `Yandex Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Яндекс Документы`, `YDB`.
