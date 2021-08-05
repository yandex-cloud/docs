---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---


# RANK_PERCENTILE (оконная)



#### Синтаксис {#syntax}


```
RANK_PERCENTILE( value [ , direction ] [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )
```

#### Описание {#description}
Выполняет относительное ранжирование. Возвращает дробный ранг (от `0` до `1`). Расчитывается как `(RANK(...) - 1) / (количество строк)`.

Если `direction` равно `"desc"` или не указано, то ранжирование происходит от большего к меньшему, если `"asc"`, то от меньшего к большему. По умолчанию используется `"desc"`.

См. также [RANK](RANK.md), [RANK_DENSE](RANK_DENSE.md), [RANK_UNIQUE](RANK_UNIQUE.md).

**Типы аргументов:**
- `value` — `Логический | Дата | Дата и время | Дробное число | Целое число | Строка | UUID`
- `direction` — `Строка`


**Возвращаемый тип**: `Дробное число`

{% note info %}

Значения аргументов (`direction`) должны быть константами.

{% endnote %}


#### Примеры {#examples}

```
RANK_PERCENTILE([Profit])
```

```
RANK_PERCENTILE([Profit] TOTAL)
```

```
RANK_PERCENTILE([Profit] WITHIN [Country])
```

```
RANK_PERCENTILE([Profit], "asc" AMONG [Date])
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
