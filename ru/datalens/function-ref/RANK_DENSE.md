---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/RANK_DENSE.md
---


# RANK_DENSE (оконная)



#### Синтаксис {#syntax}


```
RANK_DENSE( value [ , direction ] [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )
```

#### Описание {#description}
Выполняет ранжирование значений без пропусков: возвращает порядковый номер строки при сортировке по `value`. Строки, которые соответствуют одному и тому же значению `value`, имеют одно и то же значение ранга. Если первые две строки получают ранг `1`, то ранг следующей строки (если значение `value` не совпадает) будет равен `2`. Значения ранга не пропускаются.

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
RANK_DENSE([Profit])
```

```
RANK_DENSE([Profit] TOTAL)
```

```
RANK_DENSE([Profit], "desc" WITHIN [Country])
```

```
RANK_DENSE([Profit] AMONG [Date])
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
