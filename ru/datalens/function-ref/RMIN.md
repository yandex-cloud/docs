---
editable: false
---

# RMIN (оконная)



#### Синтаксис {#syntax}


```
RMIN( value [ , direction ] [ TOTAL | WITHIN ... | AMONG ... ] [ ORDER BY ... ] [ BEFORE FILTER BY ... ] )
```

#### Описание {#description}

{% note warning %}

Сортировка осуществляется на основе полей, перечисленных в области сортировки в чарте и в ORDER BY. При этом сначала берутся поля из `ORDER BY`.

{% endnote %}

Возвращает минимальное из значений в рамках окна записей, определяемого порядком сортировки и значением аргумента `direction`:

| `direction`   | Окно                            |
|:--------------|:--------------------------------|
| `"asc"`       | От первой записи до текущей.    |
| `"desc"`      | От текущей записи до последней. |

По умолчанию используется значение `"asc"`.


Аналогичное поведение у оконных функций [RSUM](RSUM.md), [RCOUNT](RCOUNT.md), [RMAX](RMAX.md), [RAVG](RAVG.md).

См. также [MIN](MIN.md), [MMIN](MMIN.md).

**Типы аргументов:**
- `value` — `Логический | Дата | Дата и время | Число | Строка | UUID`
- `direction` — `Строка`


**Возвращаемый тип**: Совпадает с типом аргументов (`value`)

{% note info %}

Значения аргументов (`direction`) должны быть константами.

{% endnote %}


#### Примеры {#examples}

```
RMIN([Profit])
```

```
RMIN([Profit], "asc")
```

```
RMIN([Profit] TOTAL)
```

```
RMIN([Profit], "desc" WITHIN [Date])
```

```
RMIN([Profit] AMONG [Date])
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
