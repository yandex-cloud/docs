---
editable: false
---

# RAVG (оконная)



#### Синтаксис {#syntax}


```
RAVG( value [ , direction ] [ TOTAL | WITHIN ... | AMONG ... ] [ ORDER BY ... ] [ BEFORE FILTER BY ... ] )
```

#### Описание {#description}
Возвращает среднее арифметическое значений в рамках окна записей, определяемого аргументом `direction`:

| `direction`   | Окно                            |
|:--------------|:--------------------------------|
| `"asc"`       | От первой записи до текущей.    |
| `"desc"`      | От текущей записи до последней. |

По умолчанию используется значение `"asc"`.


Аналогичное поведение у оконных функций [RSUM](RSUM.md), [RCOUNT](RCOUNT.md), [RMIN](RMIN.md), [RMAX](RMAX.md).

См. также [AVG](AVG.md), [MAVG](MAVG.md).

**Типы аргументов:**
- `value` — `Число`
- `direction` — `Строка`


**Возвращаемый тип**: `Целое число`

{% note info %}

Значения аргументов (`direction`) должны быть константами.

{% endnote %}

{% note warning %}

Сортировка осуществляется на основе полей, перечисленных в области сортировки в чарте и в ORDER BY. При этом сначала берутся поля из `ORDER BY`.

{% endnote %}


#### Примеры {#examples}

```
RAVG([Profit])
```

```
RAVG([Profit], "asc")
```

```
RAVG([Profit] TOTAL)
```

```
RAVG([Profit], "desc" WITHIN [Date])
```

```
RAVG([Profit] AMONG [Date])
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
