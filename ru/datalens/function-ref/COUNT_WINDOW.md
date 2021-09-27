---
editable: false
---

# COUNT (оконная)

_Функция `COUNT` также доступна как [агрегатная](COUNT.md)._

#### Синтаксис {#syntax}


```
COUNT(  [ value ] [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )
```

#### Описание {#description}
Возвращает количество элементов в заданном окне.

**Типы аргументов:**
- `value` — `Любой`


**Возвращаемый тип**: `Целое число`

#### Примеры {#examples}

```
COUNT([Profit] TOTAL)
```

```
COUNT([Profit] WITHIN [Date])
```

```
COUNT(AMONG [Date])
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
