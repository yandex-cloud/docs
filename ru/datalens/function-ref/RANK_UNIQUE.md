---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---


# RANK_UNIQUE (оконная)



#### Синтаксис {#syntax}


```
RANK_UNIQUE( value [ , direction ] [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )
```

#### Описание {#description}
Выполняет уникальное ранжирование. Возвращает порядковый номер строки при сортировке по `value`. Строки, которые соответствуют одному и тому же значению `value`, имеют разные значения ранга. Ни для каких двух строк значения не совпадают. Принимает все значения от `1` до значения, которое равно количеству строк.

Если `direction` равно `"desc"` или не указано, то ранжирование происходит от большего к меньшему, если `"asc"`, то от меньшего к большему. По умолчанию используется `"desc"`.

См. также [RANK](RANK.md), [RANK_DENSE](RANK_DENSE.md), [RANK_PERCENTILE](RANK_PERCENTILE.md).

**Типы аргументов:**
- `value` — `Логический | Дата | Дата и время | Дробное число | Целое число | Строка | UUID`
- `direction` — `Строка`


**Возвращаемый тип**: `Целое число`

{% note info %}

Значения аргументов (`direction`) должны быть константами.

{% endnote %}


#### Примеры {#examples}

```
RANK_UNIQUE([Profit])
```

```
RANK_UNIQUE([Profit] TOTAL)
```

```
RANK_UNIQUE([Profit] WITHIN [Country])
```

```
RANK_UNIQUE([Profit], "asc" AMONG [Date])
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
