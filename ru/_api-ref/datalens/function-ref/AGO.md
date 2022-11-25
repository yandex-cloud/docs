---
editable: false
---

# AGO



#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  AGO( measure, date_dimension [ , unit [ , number ] ] )
  ```

- Расширенный

  ```
  AGO( measure, date_dimension [ , unit [ , number ] ]
       [ BEFORE FILTER BY ... ]
       [ IGNORE DIMENSIONS ... ]
     )
  ```

  Подробнее:
  - [BEFORE FILTER BY](time-series-functions.md#syntax-before-filter-by)
  - [IGNORE DIMENSIONS](time-series-functions.md#syntax-ignore-dimensions)

{% endlist %}

#### Описание {#description}
Вычисляет `measure` для даты/времени с указанным смещением.
Аргумент `date_dimension` задает измерение, вдоль которого делается смещение.
Аргумент `number` задается целым числом. Может принимать отрицательные значения.
Аргумент `unit` принимает следующие значения:
- `"year"` — год;
- `"month"` — месяц;
- `"day"` — день;
- `"hour"` — час;
- `"minute"` — минута;
- `"second"` — секунда.

Возможен вариант использования `AGO( measure, date_dimension, number )`. В этом случае аргумент `unit` — количество дней.

См. также [AT_DATE](AT_DATE.md), [LAG](LAG.md).

**Типы аргументов:**
- `measure` — `Любой`
- `date_dimension` — `Дата | Дата и время`
- `unit` — `Целое число | Строка`
- `number` — `Целое число`


**Возвращаемый тип**: Совпадает с типом аргументов (`measure`)

{% note info %}

Значения аргументов (`unit`, `number`) должны быть константами.

{% endnote %}

{% note info %}

Первый аргумент функции должен быть показателем (агрегированным выражением). Отсутствие показателя приведет к ошибке.

{% endnote %}


#### Примеры {#examples}

```
AGO(SUM([Sales]), [Order Date], "month", 3)
```

```
AGO(SUM([Sales]), [Order Date], "year")
```

```
AGO(SUM([Sales]), [Order Date], 1)
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `Yandex.Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
