---
editable: false
---

# RSUM (оконная)



#### Синтаксис {#syntax}


```
RSUM( value [ , direction ] [ TOTAL | WITHIN ... | AMONG ... ] [ ORDER BY ... ] [ BEFORE FILTER BY ... ] )
```

#### Описание {#description}
Возвращает сумму значений в рамках окна записей, определяемого порядком сортировки и значением аргумента `direction`:

| `direction`   | Окно                            |
|:--------------|:--------------------------------|
| `"asc"`       | От первой записи до текущей.    |
| `"desc"`      | От текущей записи до последней. |

По умолчанию используется значение `"asc"`.


Аналогичное поведение у оконных функций [RCOUNT](RCOUNT.md), [RMIN](RMIN.md), [RMAX](RMAX.md), [RAVG](RAVG.md).

См. также [SUM](SUM.md), [MSUM](MSUM.md).

**Типы аргументов:**
- `value` — `Число`
- `direction` — `Строка`


**Возвращаемый тип**: Совпадает с типом аргументов (`value`)

{% note info %}

Значения аргументов (`direction`) должны быть константами.

{% endnote %}

{% note warning %}

Сортировка осуществляется на основе полей, перечисленных в области сортировки в чарте и в ORDER BY. При этом сначала берутся поля из `ORDER BY`.

{% endnote %}


#### Примеры {#examples}

```
RSUM([Profit])
```

```
RSUM([Profit], "asc")
```

```
RSUM([Profit] TOTAL)
```

```
RSUM([Profit], "desc" WITHIN [Date])
```

```
RSUM([Profit] AMONG [Date])
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
