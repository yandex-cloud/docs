---
editable: false
---

# RANK (оконная)



#### Синтаксис {#syntax}


```
RANK( value [ , direction ] [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )
```

#### Описание {#description}
Выполняет ранжирование значений с пропусками: возвращает порядковый номер строки при сортировке по `value`. Строки, которые соответствуют одному и тому же значению `value`, имеют одно и то же значение ранга. Если первые две строки получают ранг `1`, то ранг следующей строки (если значение `value` не совпадает) будет равен `3`. Значение `2` в этом случае пропускается.

Если `direction` равно `"desc"` или не указано, то ранжирование происходит от большего к меньшему, если `"asc"`, то от меньшего к большему. По умолчанию используется `"desc"`.

См. также [RANK_DENSE](RANK_DENSE.md), [RANK_UNIQUE](RANK_UNIQUE.md), [RANK_PERCENTILE](RANK_PERCENTILE.md).

**Типы аргументов:**
- `value` — `Логический | Дата | Дата и время | Число | Строка | UUID`
- `direction` — `Строка`


**Возвращаемый тип**: `Целое число`

{% note info %}

Значения аргументов (`direction`) должны быть константами.

{% endnote %}


#### Примеры {#examples}

```
RANK([Profit], "asc")
```

```
RANK([Profit] TOTAL)
```

```
RANK([Profit] WITHIN [Country])
```

```
RANK([Profit] AMONG [Date])
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
