---
editable: false
---

# AVG (оконная)

_Функция `AVG` также доступна как [агрегатная](AVG.md)._

#### Синтаксис {#syntax}


```
AVG( value [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )
```

#### Описание {#description}
Возвращает среднее арифметическое значений выражения. Работает только с числовыми типами данных.

**Типы аргументов:**
- `value` — `Любой`


**Возвращаемый тип**: `Дробное число`

#### Примеры {#examples}

```
AVG([Profit] TOTAL)
```

```
AVG([Profit] WITHIN [Date])
```

```
AVG([Profit] AMONG [Date])
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
